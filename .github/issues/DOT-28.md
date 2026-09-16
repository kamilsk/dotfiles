---
code: DOT-28
id: 28
database_id: 448244018
node_id: MDU6SXNzdWU0NDgyNDQwMTg=
status: closed
title: "ask to open pull request for you"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/28
created_at: 2019-05-24T16:00:14Z
updated_at: 2019-06-18T20:26:30Z
---

# ask to open pull request for you

After a push, offer to open the pull request the hosting suggests. Bitbucket Server answers a push of a new branch with a "create pull request" link and a push to an existing one with a "view pull request" link; the idea is to catch that link in the push output and ask whether to open it in the browser, so that the trip from `git please` to the review page is one keystroke. The original evidence, two push transcripts:

```
remote: Create pull request for ...:
remote:   http://.../compare/commits?sourceBranch=refs/heads/...
```

```
remote: View pull request for ... => master:
remote:   http://.../pull-requests/5
```

Expected: the push commands of the flow (`git please`, `push`) detect a `remote:` line carrying a URL, print it and, on confirmation, `open` it; GitHub's equivalent hint ("Create a pull request … by visiting:") fits the same pattern. Nothing changes when the remote prints no hint, and the push exit status is preserved.
