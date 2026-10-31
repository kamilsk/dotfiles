#!/usr/bin/env python3
"""Read the CUE allowlist, capture stored macOS preferences, validate, then emit JSON."""

import argparse
import json
import math
import os
from pathlib import Path
import platform
import plistlib
import stat
import subprocess
import sys
import tempfile
from xml.parsers.expat import ExpatError


SCHEMA = Path(__file__).resolve().with_name("settings.cue")
# one snapshot per host, <LocalHostName>.json, named like the host Brewfiles in toolset
HOSTS = SCHEMA.parent


def run(args):
    return subprocess.run(args, capture_output=True, check=True, timeout=30)


def host_name():
    # the name set in System Settings, as self-update picks the host Brewfile;
    # the network name may be a reverse DNS answer such as "mac" on a hotspot
    try:
        name = run(["/usr/sbin/scutil", "--get", "LocalHostName"]).stdout.decode().strip()
    except (OSError, subprocess.CalledProcessError, subprocess.TimeoutExpired):
        name = platform.node()
    if name.endswith(".local"):
        name = name[:-len(".local")]
    if not name or "/" in name or name.startswith("."):
        raise ValueError(f"cannot name the snapshot after host {name!r}")
    return name


def read_domain(domain):
    try:
        result = run(["/usr/bin/defaults", "export", domain, "-"])
    except subprocess.CalledProcessError:
        # A failed export does not prove that a key is absent.
        return None, "read-failed"
    except subprocess.TimeoutExpired:
        return None, "timeout"
    try:
        values = plistlib.loads(result.stdout)
    except (plistlib.InvalidFileException, ExpatError, ValueError, TypeError, OverflowError):
        return None, "invalid-plist"
    if not isinstance(values, dict):
        return None, "invalid-plist"
    return values, None


def collect(catalog):
    domains = {}
    settings = {}
    for section, entries in catalog.items():
        settings[section] = {}
        for name, source in entries.items():
            if (source["backend"], source["scope"]) != (
                "defaults", "current-user-any-host"
            ):
                raise ValueError("unsupported preference source")
            domain, key = source["domain"], source["key"]
            if domain not in domains:
                domains[domain] = read_domain(domain)
            values, error = domains[domain]
            entry = {"source": source}
            if error:
                entry.update(state="unavailable", error=error)
            elif key in values:
                value = values[key]
                if type(value) not in (bool, int, float, str) or (
                    isinstance(value, float) and not math.isfinite(value)
                ):
                    raise ValueError(
                        f"{section}.{name} ({domain}/{key}): unsupported value "
                        f"type {type(value).__name__}; expected a boolean, finite number or string"
                    )
                entry.update(state="set", value=value)
            else:
                entry.update(state="unset")
            settings[section][name] = entry
    return settings


def emit(snapshot, destination):
    # Validate the exact bytes before touching an existing destination.
    data = json.dumps(snapshot, indent=2, sort_keys=True, ensure_ascii=False,
                      allow_nan=False) + "\n"
    parent = destination.parent if destination else None
    with tempfile.NamedTemporaryFile(mode="w", suffix=".json", dir=parent,
                                     encoding="utf-8", delete=False) as output:
        temporary = Path(output.name)
        try:
            output.write(data)
            output.close()
            run(["cue", "vet", "-c", str(SCHEMA), str(temporary), "-d", "#Snapshot"])
            if destination:
                try:
                    previous = destination.lstat()
                except FileNotFoundError:
                    previous = None
                if previous is not None and stat.S_ISREG(previous.st_mode):
                    # Preserve ordinary permission bits, not special bits or ACLs.
                    os.chmod(temporary, stat.S_IMODE(previous.st_mode) & 0o777)
                os.replace(temporary, destination)
            else:
                sys.stdout.write(data)
        finally:
            temporary.unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", help="atomically replace this JSON file instead of "
                        "<LocalHostName>.json next to the schema; - writes to stdout")
    args = parser.parse_args()
    if sys.platform != "darwin":
        parser.error("capture must run on macOS, as the user whose settings you want")
    if os.geteuid() == 0:
        parser.error("run as your regular user, without sudo")
    try:
        if args.output == "-":
            destination = None
        elif args.output:
            destination = Path(args.output)
        else:
            destination = HOSTS / f"{host_name()}.json"
        catalog = json.loads(run(["cue", "export", str(SCHEMA), "-e", "catalog"]).stdout)
        snapshot = {
            "schemaVersion": 1,
            "kind": "macos-preferences-snapshot",
            "system": {
                "os": "macOS",
                "version": run(["/usr/bin/sw_vers", "-productVersion"]).stdout.decode().strip(),
                "build": run(["/usr/bin/sw_vers", "-buildVersion"]).stdout.decode().strip(),
            },
            "settings": collect(catalog),
        }
        emit(snapshot, destination)
        unavailable = sum(entry["state"] == "unavailable"
                          for section in snapshot["settings"].values()
                          for entry in section.values())
        if unavailable:
            print(f"Exported partial snapshot: {unavailable} preferences unavailable", file=sys.stderr)
            return 3
    except subprocess.CalledProcessError as error:
        print(error.stderr.decode(errors="replace").strip(), file=sys.stderr)
        return 1
    except (OSError, ValueError, TypeError, subprocess.TimeoutExpired) as error:
        print(f"Export failed: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
