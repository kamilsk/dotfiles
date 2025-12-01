---
id: 860
database_id: 4758419694
node_id: I_kwDOCTsueM8AAAABG5-47g
status: closed
title: "git: alias: add lock/unlock to temporarily disable push"
labels: [type: feature, scope: code, impact: low, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/860
created_at: 2026-06-27T13:06:56Z
updated_at: 2026-06-27T17:29:23Z
---

# git: alias: add lock/unlock to temporarily disable push

**Motivation:** sometimes I want to *temporarily* forbid `git push` to a remote while keeping `git fetch`/`git pull` working — e.g. to freeze a branch during a long rebase/experiment, to avoid accidental publishing, or to guard a shared mirror — and later restore it without having to remember the original URL.

**Interface**

```bash
$ git lock          # disable push to origin; fetch/pull still work
$ git unlock        # restore push (pushurl falls back to the fetch url)
```

**PoC**

```bash
# lock: point the push URL at a recognizable sentinel (shows up in `git remote -v`)
$ git remote set-url --push origin no_push

# unlock: drop the pushurl so push falls back to the fetch url (true original state)
$ git config --unset remote.origin.pushurl
```

Why a sentinel + `--unset` rather than `/dev/null` + restore-from-fetch-url:

- **symmetric** — `unlock` restores the exact original state (`pushurl` unset) without reading or rewriting the fetch url, so it cannot corrupt it;
- **self-documenting** — `no_push (push)` is visible in `git remote -v`;
- **detectable** — lock state is trivial to check for idempotency/status.

**Out of scope for the PoC**

- optional remote argument (`git lock [remote]`), default `origin`
- back up and restore a pre-existing custom/multiple `pushurl` (the PoC assumes `pushurl` is originally unset — the common case)
- idempotency (`unlock` when already unlocked) and reporting the current lock state
