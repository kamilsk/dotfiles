---
code: DOT-94
id: 95
database_id: 780394236
node_id: MDU6SXNzdWU3ODAzOTQyMzY=
status: closed
state_reason: completed
milestone:
title: "add links to source code in Brewfile"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/95
created_at: 2021-01-06T09:51:49Z
updated_at: 2026-09-17T11:15:50Z
---

# add links to source code in Brewfile

Annotate every entry of the Brewfile with where the software comes from — its repository or site — so that a bare formula name (`jid`, `gia`, `plumber`, `mergestat`) can be recognised months later and reviewed for removal.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/95#issuecomment-5711717973
Code vs intent: `toolset/Inventory.yaml` has not been updated since 2023 and disagrees with the Brewfiles (lists Bartender, Lens, Miro, old taps; lacks Warp, Zed, Cursor, the AI clients, Ice, Raycast). It is documentation drift rather than a source of truth; #375 wanted to build on it.
-->
