---
id: 424
database_id: 1377645511
node_id: I_kwDOCTsueM5SHTPH
status: closed
title: "config: git: prevent autoSetupRemote duplication"
labels: [type: bug, severity: minor, scope: code, impact: low, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/424
created_at: 2022-09-19T09:12:12Z
updated_at: 2022-09-27T17:16:24Z
---

# config: git: prevent autoSetupRemote duplication

**Motivation:** prevent bloating of `.gitconfig`.

**Details**

```
[commit]
	gpgSign = true
[tag]
	gpgSign = true
[push]
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
	autoSetupRemote = true
```
