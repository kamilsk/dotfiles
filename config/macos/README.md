# macOS settings as code

This directory implements the first stage: a repeatable snapshot of selected
stored macOS preferences, with their sources and a CUE schema. The intended
progression is **capture → desired configuration → diff/plan → apply**.
Only capture and validation are implemented today.

System Settings is the interface to multiple stores, rather than one
configuration file. A preference dump alone cannot reconstruct every control.
The working distinction is between **stored values**, **effective behavior**,
and **desired configuration**. This snapshot describes the first of these.

## Files and responsibilities

| File | Responsibility |
| --- | --- |
| `<LocalHostName>.json`, e.g. [OctoMac-Pro.json](OctoMac-Pro.json) | One snapshot per host, named like the host Brewfiles in `toolset`: observed values and read states, plus the macOS version and build. Generated, not an instruction to change the machine. |
| [settings.cue](settings.cue) | `#Settings` holds the catalog, value types and source mappings; `catalog` exposes the sources to the exporter; `#Snapshot` validates the result. |
| [export.py](export.py) | Reads the catalog, collects preferences, validates JSON and emits it. Contains no second list of preference keys. |
| [test/macos_settings.py](../../test/macos_settings.py) | Offline regression checks for capture, schema validation, output and CLI errors. |

The snapshot has `schemaVersion: 1` and `kind: "macos-preferences-snapshot"`.
Friendly paths such as `dock.autoHide` keep it readable; the `source` on each
entry records the backend, scope, domain and exact native key.

## Capture and validate

From the dotfiles root, with Python 3.8+ and the `cue` CLI on PATH:

```sh
python3 config/macos/export.py
cue vet -c config/macos/settings.cue "config/macos/$(scutil --get LocalHostName).json" -d '#Snapshot'
git diff -- config/macos
```

Run as your regular user, without `sudo`. The snapshot goes to
`config/macos/<LocalHostName>.json`: the name set in System Settings, the one
`self-update` uses to pick the host Brewfile, not the network name, which can be
a reverse DNS answer such as `mac`. `--output <path>` writes elsewhere and
`--output -` writes to stdout. The destination is replaced atomically after
validation.
`git diff` shows changes once the snapshot is tracked; it does not display a
new untracked file's contents.

| Exit code | Meaning | Effect on the destination |
| --- | --- | --- |
| `0` | All catalog sources were read; individual keys may still be `unset`. | Writes the validated snapshot. |
| `1` | Collection, serialization, validation or output failed. | A failure before replacement preserves the previous snapshot. |
| `2` | Invalid arguments, non-macOS platform or a refused root run. | Writes no snapshot; preserves the previous file. |
| `3` | Some sources were unavailable. | Writes a validated **partial snapshot**, replacing the previous file. |

`--help` exits 0 after printing usage, without writing a snapshot. Code 3 is
distinct from argparse's code 2 so automation can tell a partial capture from
a run that never started collecting.

New snapshot files are owner-readable/writable only (0600). Replacing an
existing regular file preserves its ordinary permission bits. Atomic replacement
creates a new file: ownership, ACLs, extended attributes and special mode bits
are not preserved. A symlink destination is replaced as a directory entry;
its target is not overwritten.

Automation must inspect the exit code: a valid JSON file can still represent
incomplete observations. Use a separate output path when comparing a new
capture with an existing baseline.

## How collection works

1. Export the source catalog from CUE with `cue export … -e catalog`.
2. Read each unique domain once with `defaults export <domain> -`.
3. Parse the property list in memory and select only catalog keys.
4. Record each key's read state and, when present, its native scalar value.
5. Serialize sorted JSON, validate it against `#Snapshot`, then emit it.

There are currently five domains: `NSGlobalDomain`, `com.apple.dock`,
`com.apple.AppleMultitouchTrackpad`, `com.apple.universalaccess`, and
`com.apple.screencapture`. Every source has backend `defaults` and scope
`current-user-any-host`. Despite its name, `NSGlobalDomain` does not mean
system-wide settings for every user.

The exporter reads entire selected domains into memory, but saves only
allowlisted keys. The current catalog excludes account data, credentials,
hardware identifiers, file paths and application histories. Future additions
need the same review; an allowlist is only as selective as its entries.

The implementation reads preferences through `defaults`, rather than editing
their underlying plist files. It does not change system settings, restart
services or install profiles. Reads are sequential, not a system-wide
transaction. Sorted keys and the absence of timestamps make the output stable
when both the captured preferences and OS metadata are unchanged.

## Reading an observation

| State | Evidence | What it does not establish |
| --- | --- | --- |
| `set` | The key exists in the exported domain; `value` preserves its stored value. | That the current OS uses it, that it wins over another source, or that the UI currently shows it. |
| `unset` | The domain was read successfully and the key was absent. | False, disabled, unsupported, a known factory default, or an instruction to delete a key. |
| `unavailable` | Reading or decoding the domain failed. | Whether the key exists or what its value would be. |

A setting absent from the **catalog** was never inspected. It is different
from an inspected key with state `unset`; do not interpret an omitted section
as successfully captured or disabled.

For `unavailable`, `error` is `read-failed`, `invalid-plist`, or `timeout`.
`read-failed` is deliberately broad: a nonzero `defaults` exit does not reliably
distinguish a missing domain from access restrictions or another read error.
Each subprocess has a 30-second timeout. Error messages from domain reads are
not copied into the snapshot.

Example from the initial capture:

```json
{
  "source": {
    "backend": "defaults",
    "scope": "current-user-any-host",
    "domain": "com.apple.dock",
    "key": "autohide"
  },
  "state": "set",
  "value": true
}
```

The schema requires metadata, sections, settings and every source field to be
present in the JSON itself. It requires a value for `set`, forbids it for the
other states, and requires an error for `unavailable`. These data constraints
are derived from the catalog without filling missing fields from its constants.
Validation does not infer missing values or certify a preference's effect on
the UI.

Native types and units are retained. Switches may be booleans or integer 0/1;
Dock size is numeric; keyboard repeat values are not converted to UI slider
positions. Version 1 only supports scalar booleans, numbers and strings.
Arrays, dictionaries, binary data and dates require a deliberate extension;
they cause the entire capture to fail with code 1 and preserve the previous
destination. Non-finite numbers are rejected the same way. Diagnostics name the
section, setting, source and unsupported type, without printing the value. A
supported scalar of the wrong type for a particular setting also fails the
entire capture, with a CUE path-qualified error. Neither case becomes a partial
snapshot or silently drops the offending setting.

## Current coverage and observed evidence

The catalog contains **32 keys across 8 sections**. This is a count of selected
preferences, not a percentage of System Settings coverage. Screenshot options
also extend beyond the System Settings application itself.

The counts below describe the initial capture on **2026-11-07**, macOS
**27.0.1**, build **26A434**. They are a historical checkpoint, not live counters.
The JSON and CUE catalog are authoritative for subsequent captures.

| Section | Selected settings | Keys | `set` | `unset` |
| --- | --- | ---: | ---: | ---: |
| Appearance | Interface style, automatic switching, accent color, highlight color, scroll bars | 5 | 1 | 4 |
| Dock | Auto-hide, position, size, magnification and its size, recent apps, minimize destination and effect | 8 | 2 | 6 |
| Mission Control | Space reordering, grouping windows by application | 2 | 0 | 2 |
| Keyboard | Repeat interval and delay, standard function keys, spelling correction, capitalization, period insertion, smart quotes and dashes | 8 | 3 | 5 |
| Trackpad | Tap to click, secondary click, three-finger drag | 3 | 3 | 0 |
| Scrolling | Natural scroll direction | 1 | 0 | 1 |
| Accessibility | Reduced motion, reduced transparency | 2 | 0 | 2 |
| Screenshots | Format, disabled shadow, thumbnail | 3 | 0 | 3 |
| **Total** | | **32** | **9** | **23** |

All five domains were readable; no entries were `unavailable`. The stored
values included `AppleInterfaceStyle = "Dark"`, Dock auto-hide enabled and size
`64.0`, spelling correction/capitalization/period insertion disabled, and tap
to click enabled with secondary click and three-finger drag disabled in the
selected trackpad domain. These observations were not cross-checked against
the visible controls or against attached hardware.

Verification performed during the initial implementation:

- A live capture passed CUE validation; a second capture was byte-identical.
- Seven invalid variants were rejected: wrong value type, missing `set` value,
  value on `unset`, missing error on `unavailable`, wrong source key, unknown
  setting and missing setting.
- Simulated reads checked false values, absent keys, read failures, timeouts,
  malformed plists and reading each domain only once.
- A validation failure preserved the previous destination file.

These initial checks were ad hoc. The later review cycle added the reproducible
suite below. Only one macOS version and machine were exercised. Successfully
reading a key is weaker evidence than verifying its UI mapping and behavior on
that release.

## Regression checks

From the repository root, with Python 3.8+ and `cue` on PATH:

```sh
python3 -B -m unittest discover -s test -p macos_settings.py
```

The suite uses temporary files and simulated preference reads; it does not read
or change real macOS preferences. It exercises real CUE validation, including
missing constant-valued metadata and source fields, invalid states and types,
output preservation, permission bits, stable serialization, native value
diagnostics and distinct CLI outcomes. `-B` avoids leaving Python bytecode in
the checkout. The suite has been run with Python 3.15.2 and CUE 0.17.1; older
supported Python versions and other CUE versions have not been exercised here.

For a separate live smoke check, capture twice to temporary output paths and
compare their bytes, then validate both against `#Snapshot`. That checks the
current machine's selected storage sources; the offline suite alone does not
establish their availability or their mapping to System Settings controls.

## Blind spots

| Gap | Consequence | Work needed |
| --- | --- | --- |
| ByHost preferences | A machine-specific value may exist outside the exported scope. | Add a separate current-host reader and retain scope provenance. |
| Managed preferences and profiles | Policy may override a stored user preference. | Inventory supported management sources and distinguish policy from user choice. |
| Registration defaults and fallback values | An absent key can still produce a definite UI value. | Resolve effective values only where the lookup behavior is understood; retain unknowns elsewhere. |
| System-wide and other-user settings | The snapshot describes only the invoking user's selected domains. | Add explicitly scoped readers; do not use `sudo` to reinterpret a user capture. |
| OS changes, old keys and hardware differences | A readable key can be obsolete, inactive or relevant to another device. | Record evidence per release and device context; verify mappings before relying on them. |
| Cached or asynchronously saved state | A capture may lag a recent UI change; several domains can reflect different moments. | Use stable before/after observations when investigating a mapping. |
| Native structured values | Many settings cannot fit the current scalar schema. | Define representations and validation before collecting arrays, dictionaries or binary values. |
| Multiple Macs | OS version/build alone cannot identify which machine a snapshot belongs to. | Choose explicit file names or a non-sensitive machine label before keeping several baselines. |

The following feature areas are **not covered**. Suggested readers are research
directions, not implemented integrations or promises of complete coverage.

| Area | Direction to investigate |
| --- | --- |
| Power, sleep, battery behavior | Read-only `pmset` queries; separate configured values from current power state. |
| Network, DNS, proxies, VPN | Read-only `networksetup`/`scutil` queries and supported APIs; distinguish saved configuration from active connections and omit credentials. |
| System-level settings such as date/time | Check relevant `systemsetup` read operations and their access requirements. |
| Displays, sound, Bluetooth and device-specific input | Investigate supported APIs and device scopes; attached-device inventory alone is not a settings export. |
| Wallpaper, notifications, Focus, login items | Investigate each feature's storage/API separately and verify its UI mapping. |
| Accounts and privacy/security permissions | Define a bounded inventory; mark manual or restricted observations explicitly. Ordinary preferences are not a complete permission inventory. |

Configuration profiles can express supported managed settings, but they are
not a universal export of the System Settings UI or a drop-in replacement for
capturing a personal Mac's preferences.

## Extending the catalog

1. Pick a concrete control or preference. Record its UI location, native key,
   domain, scope, expected type and the macOS release on which it was observed.
2. Establish what the source proves. If a mapping needs before/after GUI
   changes, investigate those separately from normal capture and restore the
   original setting afterward. A familiar key name alone is not verification.
3. For an existing backend/scope and scalar type, add the entry to `#Settings`
   in `settings.cue`. There is no Python key list to update. For another scope,
   backend or value shape, extend the model and reader first; the exporter
   currently rejects unsupported source combinations.
4. Preserve false and zero, keep absence separate from read failure, and ensure
   only intended fields reach JSON. Do not guess defaults to fill gaps.
5. Validate the capture and inspect its diff. When adding a reader or changing
   representation, verify failure cases as well as successful reads. Record
   the evidence level: storage observed, UI mapping verified, or behavior tested.
6. Update this coverage inventory. Keep the dated initial checkpoint historical;
   add a new checkpoint when useful. Change `schemaVersion` when the snapshot
   representation or meaning changes incompatibly, with a migration explanation.

## Expansion plan

| Stage | Status | Result to aim for |
| --- | --- | --- |
| 1. Capture selected preferences | Implemented | Repeatable JSON, CUE catalog/schema, explicit read states and validated output. |
| 2. Inventory remaining settings and verify existing mappings | Next | A section-by-section list of mapped, unverified, inaccessible and manual settings, with version/scope evidence. |
| 3. Expand readers | Planned | Current-host sources first, then selected power/network/system readers. Keep configured state distinct from runtime observations. |
| 4. Describe desired configuration | Planned | A separate model for user intent; explicit set/reset/unmanaged choices. Unknown observations must not turn into desired values. |
| 5. Compare and plan | Planned | Explain current versus desired values, the responsible source, uncertainty, required access and any restart/logout implications. |
| 6. Apply selected settings | Planned | Setting-specific, repeatable changes with previous-state capture, read-back verification and documented recovery limits. |

Expanding capture does not automatically authorize or make application reliable.
Before adding `apply`, establish which setting is writable, which source wins,
and how success is checked. In particular, an `unset` observation must never
silently become a delete operation. The existing snapshot remains an observation
even if someone edits its JSON by hand.

## References

- [Apple: UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)
  describes preference domains and recommends `defaults` instead of modifying
  preference files directly.
- [Apple: preference domains](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/AboutPreferenceDomains/AboutPreferenceDomains.html)
  explains lookup and registration defaults; it is an archived conceptual guide,
  not a current catalog of System Settings keys.
- [Apple: Device Management settings](https://support.apple.com/en-ca/guide/mac-help/mh35474/27/mac/27)
  describes configuration profiles and their management interface.
- [CUE: vet](https://cuelang.org/docs/reference/command/cue-help-vet/)
  documents selecting a validation schema with `-d`.
- [nix-darwin options](https://nix-darwin.github.io/nix-darwin/manual/)
  provides an existing declarative macOS configuration reference. Its mappings
  can inform research; they do not verify this machine's effective settings.
