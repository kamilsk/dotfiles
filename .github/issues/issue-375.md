---
id: 375
database_id: 1331106556
node_id: I_kwDOCTsueM5PVxL8
status: open
title: "inventory: mac: extend database and manage Launchpad by it"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/375
created_at: 2022-08-07T19:47:34Z
updated_at: 2022-08-14T18:52:27Z
---

# inventory: mac: extend database and manage Launchpad by it

**Motivation:** I still have some manual jobs when I'm configuring existing MacBooks.

**Inconveniences:**

- Support different versions, for example, 1Password 7 and 1Password 8

  https://github.com/kamilsk/dotfiles/blob/76a4b4c1ba7aef4fe106c923729d0db409d1b80a/toolset/Inventory.yaml#L3-L14, it's one entity, but I split it into two.

- There is no way to support iOS apps.

- There is no way to manage devices specifically, for example, now I install all software, but I want to separate them by "profiles".

- There is no way to manage Launchpad after installation/reinstallation of software. It requires a manual job.

  `echo /private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db` is a path for Launchpad's database.

  - show folders

    ```sql
    select i.uuid, g.title, i.type
    from items I
             inner join groups g on g.item_id = i.rowid
    order by g.item_id;
    ```

  - show applications

    ```sql
    select i.uuid, a.title, i.type
    from items I
             inner join apps a on a.item_id = i.rowid
    order by a.item_id;
    ```

  I want to define the Launchpad section and write a migration to group items.
