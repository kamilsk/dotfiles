---
id: 443
database_id: 1402337594
node_id: I_kwDOCTsueM5Tlfk6
status: closed
title: "ci/cd: dependabot: change commit message"
labels: [type: improvement, scope: inventory, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/443
created_at: 2022-10-09T17:12:11Z
updated_at: 2022-10-12T10:25:14Z
---

# ci/cd: dependabot: change commit message

**Motivation:** to be precise.

- `gitsubmodule` -> `deps:`
- `directory: /tools/` -> `deps: tools:` or `tools: deps:`

See the docs https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file#commit-message.
Don't forget about https://www.conventionalcommits.org/en/v1.0.0/.

Related to octomation/go-module/issues/65.
