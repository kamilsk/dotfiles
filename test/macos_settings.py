"""Offline regression checks for macOS capture. Requires Python 3.8+ and cue."""

from contextlib import redirect_stderr, redirect_stdout
import copy
from datetime import datetime
import importlib.util
import io
import json
from pathlib import Path
import plistlib
import stat
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]
SCHEMA = ROOT / "config/macos/settings.cue"
SPEC = importlib.util.spec_from_file_location("macos_export", ROOT / "config/macos/export.py")
exporter = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(exporter)


class CaptureTests(unittest.TestCase):
    def test_selects_only_catalog_keys_and_preserves_false_zero_and_absence(self):
        source = {"backend": "defaults", "scope": "current-user-any-host", "domain": "test"}
        catalog = {"section": {key: dict(source, key=key) for key in ("flag", "size", "absent")}}
        values = {"flag": False, "size": 0, "unrelated-private-key": "must not leak"}
        with patch.object(exporter, "read_domain", return_value=(values, None)) as reader:
            entries = exporter.collect(catalog)["section"]
        self.assertIs(entries["flag"]["value"], False)
        self.assertEqual(entries["size"]["value"], 0)
        self.assertEqual(entries["absent"]["state"], "unset")
        self.assertNotIn("value", entries["absent"])
        self.assertNotIn("must not leak", json.dumps(entries))
        reader.assert_called_once_with("test")

    def test_failed_read_is_not_absence(self):
        source = {"backend": "defaults", "scope": "current-user-any-host",
                  "domain": "test", "key": "flag"}
        with patch.object(exporter, "read_domain", return_value=(None, "read-failed")):
            entry = exporter.collect({"section": {"flag": source}})["section"]["flag"]
        self.assertEqual(entry["state"], "unavailable")
        self.assertEqual(entry["error"], "read-failed")
        self.assertNotIn("value", entry)

    def test_unsupported_values_name_the_setting_without_printing_its_value(self):
        source = {"backend": "defaults", "scope": "current-user-any-host",
                  "domain": "test", "key": "native-key"}
        values = [[], {}, b"private-value", datetime(2026, 1, 1), float("inf"), float("nan")]
        for value in values:
            with self.subTest(type=type(value).__name__), patch.object(
                exporter, "read_domain", return_value=({"native-key": value}, None)
            ), self.assertRaises(ValueError) as error:
                exporter.collect({"section": {"setting": source}})
            self.assertIn("section.setting (test/native-key)", str(error.exception))
            self.assertIn(type(value).__name__, str(error.exception))
            self.assertNotIn("private-value", str(error.exception))

    def test_plist_input_and_read_errors(self):
        values = {"flag": False, "size": 0}
        for fmt in (plistlib.FMT_XML, plistlib.FMT_BINARY):
            with self.subTest(format=fmt), patch.object(
                exporter, "run", return_value=subprocess.CompletedProcess(
                    [], 0, stdout=plistlib.dumps(values, fmt=fmt)
                )
            ) as runner:
                self.assertEqual(exporter.read_domain("test"), (values, None))
                runner.assert_called_once_with(["/usr/bin/defaults", "export", "test", "-"])
        for payload in (b"invalid", b'<?xml version="1.0"?><plist><dict>', plistlib.dumps([])):
            with self.subTest(payload=payload), patch.object(
                exporter, "run", return_value=subprocess.CompletedProcess([], 0, stdout=payload)
            ):
                self.assertEqual(exporter.read_domain("test"), (None, "invalid-plist"))
        for error, expected in (
            (subprocess.CalledProcessError(1, ["defaults"]), "read-failed"),
            (subprocess.TimeoutExpired(["defaults"], 30), "timeout"),
        ):
            with self.subTest(error=expected), patch.object(exporter, "run", side_effect=error):
                self.assertEqual(exporter.read_domain("test"), (None, expected))


class SnapshotTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        result = subprocess.run(["cue", "export", str(SCHEMA), "-e", "catalog"],
                                capture_output=True, check=True)
        cls.catalog = json.loads(result.stdout)
        cls.baseline = {
            "kind": "macos-preferences-snapshot", "schemaVersion": 1,
            "system": {"os": "macOS", "version": "27.0.1", "build": "TEST"},
            "settings": {
                section: {name: {"source": source, "state": "unset"}
                          for name, source in entries.items()}
                for section, entries in cls.catalog.items()
            },
        }

    def vet(self, data):
        with tempfile.TemporaryDirectory() as directory:
            candidate = Path(directory) / "candidate.json"
            candidate.write_text(json.dumps(data), encoding="utf-8")
            result = subprocess.run(["cue", "vet", "-c", str(SCHEMA), str(candidate),
                                     "-d", "#Snapshot"], capture_output=True)
        return result.returncode == 0

    def test_complete_snapshots_and_native_scalar_values(self):
        self.assertTrue(self.vet(self.baseline))
        for value in (True, False, 0, 1):
            data = copy.deepcopy(self.baseline)
            data["settings"]["dock"]["autoHide"].update(state="set", value=value)
            with self.subTest(value=value):
                self.assertTrue(self.vet(data))
        data["settings"]["dock"]["iconSize"].update(state="set", value=64.0)
        data["settings"]["appearance"]["interfaceStyle"].update(state="set", value="Dark")
        data["settings"]["dock"]["position"].update(state="unavailable", error="read-failed")
        self.assertTrue(self.vet(data))

    def test_required_fields_must_exist_in_the_json(self):
        paths = [(field,) for field in ("kind", "schemaVersion", "system", "settings")]
        paths += [("system", field) for field in ("os", "version", "build")]
        paths += [("settings", "dock"), ("settings", "dock", "autoHide")]
        prefix = ("settings", "dock", "autoHide")
        paths += [prefix + (field,) for field in ("state", "source")]
        paths += [prefix + ("source", field) for field in ("backend", "scope", "domain", "key")]
        for path in paths:
            data = copy.deepcopy(self.baseline)
            target = data
            for component in path[:-1]:
                target = target[component]
            del target[path[-1]]
            with self.subTest(missing=".".join(path)):
                self.assertFalse(self.vet(data))

    def test_rejects_invalid_states_and_types(self):
        cases = [
            {"state": "set"}, {"state": "set", "value": "yes"},
            {"state": "set", "value": 2}, {"state": "set", "value": []},
            {"state": "set", "value": None},
            {"state": "set", "value": True, "error": "timeout"},
            {"state": "unset", "value": False}, {"state": "unset", "error": "timeout"},
            {"state": "unavailable"}, {"state": "unavailable", "error": "unknown"},
            {"state": "unavailable", "error": "timeout", "value": False},
            {"state": "unknown"},
        ]
        for observation in cases:
            data = copy.deepcopy(self.baseline)
            data["settings"]["dock"]["autoHide"].update(observation)
            with self.subTest(observation=observation):
                self.assertFalse(self.vet(data))

    def test_rejects_unknown_settings_and_wrong_sources(self):
        data = copy.deepcopy(self.baseline)
        data["settings"]["dock"]["typo"] = data["settings"]["dock"]["autoHide"]
        self.assertFalse(self.vet(data))
        data = copy.deepcopy(self.baseline)
        data["settings"]["dock"]["autoHide"]["source"]["key"] = "wrong"
        self.assertFalse(self.vet(data))

    def test_invalid_output_preserves_destination_and_removes_temporary_file(self):
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "existing.json"
            destination.write_bytes(b"previous snapshot\n")
            for value, error in (("yes", subprocess.CalledProcessError), (b"binary", TypeError)):
                data = copy.deepcopy(self.baseline)
                data["settings"]["dock"]["autoHide"].update(state="set", value=value)
                with self.subTest(value=value), self.assertRaises(error):
                    exporter.emit(data, destination)
                self.assertEqual(destination.read_bytes(), b"previous snapshot\n")
                self.assertEqual(list(Path(directory).iterdir()), [destination])

    def test_repeated_output_is_identical_and_stdout_matches_file(self):
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "settings.json"
            exporter.emit(self.baseline, destination)
            first = destination.read_bytes()
            exporter.emit(self.baseline, destination)
            self.assertEqual(first, destination.read_bytes())
            with redirect_stdout(io.StringIO()) as output:
                exporter.emit(self.baseline, None)
            self.assertEqual(output.getvalue().encode("utf-8"), first)

    def test_output_preserves_existing_permissions_and_new_files_are_private(self):
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "settings.json"
            exporter.emit(self.baseline, destination)
            self.assertEqual(stat.S_IMODE(destination.stat().st_mode), 0o600)
            for mode in (0o644, 0o640, 0o600):
                destination.chmod(mode)
                exporter.emit(self.baseline, destination)
                self.assertEqual(stat.S_IMODE(destination.stat().st_mode), mode)

    def test_usage_errors_and_refused_runs_return_two_without_writing(self):
        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "settings.json"
            destination.write_bytes(b"previous\n")
            result = subprocess.run([sys.executable, "-B", str(ROOT / "config/macos/export.py"),
                                     "--bogus", "--output", str(destination)], capture_output=True)
            self.assertEqual(result.returncode, 2)
            self.assertEqual(result.stdout, b"")
            for platform, uid in (("linux", 501), ("darwin", 0)):
                with self.subTest(platform=platform, uid=uid), \
                     patch.object(exporter.sys, "argv", ["export.py", "--output", str(destination)]), \
                     patch.object(exporter.sys, "platform", platform), \
                     patch.object(exporter.os, "geteuid", return_value=uid), \
                     patch.object(exporter, "collect") as collect, \
                     redirect_stderr(io.StringIO()), self.assertRaises(SystemExit) as error:
                    exporter.main()
                self.assertEqual(error.exception.code, 2)
                collect.assert_not_called()
                self.assertEqual(destination.read_bytes(), b"previous\n")

    def test_symlink_destination_is_replaced_without_changing_its_target(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "original.json"
            target.write_bytes(b"keep target\n")
            destination = Path(directory) / "settings.json"
            destination.symlink_to(target)
            exporter.emit(self.baseline, destination)
            self.assertFalse(destination.is_symlink())
            self.assertEqual(target.read_bytes(), b"keep target\n")
            self.assertEqual(stat.S_IMODE(destination.stat().st_mode), 0o600)
            self.assertEqual(json.loads(destination.read_text()), self.baseline)

    def test_main_writes_partial_snapshot_and_returns_three(self):
        partial = copy.deepcopy(self.baseline["settings"])
        partial["dock"]["autoHide"].update(state="unavailable", error="read-failed")
        real_run = exporter.run

        def run(args):
            if args[0] == "/usr/bin/sw_vers":
                return subprocess.CompletedProcess(args, 0, stdout=b"test\n")
            return real_run(args)

        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "settings.json"
            destination.write_bytes(b"previous\n")
            with patch.object(exporter.sys, "argv", ["export.py", "--output", str(destination)]), \
                 patch.object(exporter.sys, "platform", "darwin"), \
                 patch.object(exporter.os, "geteuid", return_value=501), \
                 patch.object(exporter, "collect", return_value=partial), \
                 patch.object(exporter, "run", side_effect=run), \
                 redirect_stderr(io.StringIO()) as error:
                self.assertEqual(exporter.main(), 3)
            self.assertIn("1 preferences unavailable", error.getvalue())
            data = json.loads(destination.read_text())
            self.assertEqual(data["settings"], partial)
            self.assertTrue(self.vet(data))

    def test_main_reports_unsupported_value_and_preserves_destination(self):
        real_run = exporter.run

        def run(args):
            if args[0] == "/usr/bin/sw_vers":
                return subprocess.CompletedProcess(args, 0, stdout=b"test\n")
            return real_run(args)

        with tempfile.TemporaryDirectory() as directory:
            destination = Path(directory) / "settings.json"
            destination.write_bytes(b"previous\n")
            with patch.object(exporter.sys, "argv", ["export.py", "--output", str(destination)]), \
                 patch.object(exporter.sys, "platform", "darwin"), \
                 patch.object(exporter.os, "geteuid", return_value=501), \
                 patch.object(exporter, "read_domain", return_value=({"autohide": b"private-value"}, None)), \
                 patch.object(exporter, "run", side_effect=run), \
                 redirect_stderr(io.StringIO()) as error:
                self.assertEqual(exporter.main(), 1)
            self.assertIn("dock.autoHide (com.apple.dock/autohide)", error.getvalue())
            self.assertNotIn("private-value", error.getvalue())
            self.assertEqual(destination.read_bytes(), b"previous\n")

    def run_main(self, argv, hosts, run_for):
        real_run = exporter.run

        def run(args):
            if args[0] in run_for:
                return run_for[args[0]](args)
            return real_run(args)

        with patch.object(exporter.sys, "argv", ["export.py", *argv]), \
             patch.object(exporter.sys, "platform", "darwin"), \
             patch.object(exporter.os, "geteuid", return_value=501), \
             patch.object(exporter, "HOSTS", hosts), \
             patch.object(exporter, "collect", return_value=self.baseline["settings"]), \
             patch.object(exporter, "run", side_effect=run), \
             redirect_stdout(io.StringIO()) as output, redirect_stderr(io.StringIO()):
            return exporter.main(), output.getvalue()

    def test_default_destination_is_named_after_the_local_host_name(self):
        version = lambda args: subprocess.CompletedProcess(args, 0, stdout=b"test\n")
        for answer, expected in ((b"OctoMac-Pro\n", "OctoMac-Pro.json"),
                                 (b"OctoMac-Air.local\n", "OctoMac-Air.json")):
            with self.subTest(answer=answer), tempfile.TemporaryDirectory() as directory:
                hosts = Path(directory)
                scutil = lambda args, answer=answer: subprocess.CompletedProcess(args, 0, stdout=answer)
                code, output = self.run_main([], hosts, {"/usr/bin/sw_vers": version,
                                                         "/usr/sbin/scutil": scutil})
                self.assertEqual((code, output), (0, ""))
                self.assertEqual([path.name for path in hosts.iterdir()], [expected])
                self.assertEqual(json.loads((hosts / expected).read_text())["settings"],
                                 self.baseline["settings"])

    def test_host_falls_back_to_the_node_name_and_refuses_an_unusable_one(self):
        def unset(args):
            raise subprocess.CalledProcessError(1, args)

        version = lambda args: subprocess.CompletedProcess(args, 0, stdout=b"test\n")
        for node, expected in (("OctoMac-mini.local", ["OctoMac-mini.json"]), ("", []), ("..", [])):
            with self.subTest(node=node), tempfile.TemporaryDirectory() as directory, \
                 patch.object(exporter.platform, "node", return_value=node):
                hosts = Path(directory)
                code, _ = self.run_main([], hosts, {"/usr/bin/sw_vers": version,
                                                    "/usr/sbin/scutil": unset})
                self.assertEqual(code, 0 if expected else 1)
                self.assertEqual(sorted(path.name for path in hosts.iterdir()), expected)

    def test_dash_output_writes_stdout_and_no_host_file(self):
        version = lambda args: subprocess.CompletedProcess(args, 0, stdout=b"test\n")
        with tempfile.TemporaryDirectory() as directory:
            hosts = Path(directory)
            code, output = self.run_main(["--output", "-"], hosts, {"/usr/bin/sw_vers": version})
            self.assertEqual(code, 0)
            self.assertEqual(json.loads(output)["settings"], self.baseline["settings"])
            self.assertEqual(list(hosts.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
