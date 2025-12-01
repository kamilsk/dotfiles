---
id: 481
database_id: 1488399132
node_id: I_kwDOCTsueM5Ytysc
status: open
title: "bash: alias: add maintain command"
labels: [type: feature, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/481
created_at: 2022-12-10T11:26:51Z
updated_at: 2022-12-10T11:26:52Z
---

# bash: alias: add maintain command

**Motivation:** simplify my contribution process.

**Interface**

```bash
$ maintain
# {maintainer github contribution suggest --delta; maintainer github contribution suggest --delta --target=10 2022-05-01; maintainer github contribution lookup /-2}
 Day / Week   #2   #3   #4   #5   #6   #7
------------ ---- ---- ---- ---- ---- ----
 Sunday       8    1    -    3    6    6
 Monday       7    -    6    2    6    6
 Tuesday      1    1    2    9    2    6
 Wednesday    1    1    2    1    -    -
 Thursday     2    2    2    -    -    6
 Friday       8    -    -    -    4    4
 Saturday     8    1    -    3    2    6
------------ ---- ---- ---- ---- ---- ----
 Suggestion is 2022-01-10: -334d, 7 → 8
 Day / Week   #20   #21   #22   #23   #24   #25
------------ ----- ----- ----- ----- ----- -----
 Sunday       10     5     5     5     5     5
 Monday        5     5     4     5     3     5
 Tuesday       6     5     5     4     5     5
 Wednesday     6     5     5     5     5     5
 Thursday      6     5     4     4     3     4
 Friday        6     5     5     5     4     5
 Saturday      6     5     5     4     3     5
------------ ----- ----- ----- ----- ----- -----
 Suggestion is 2022-05-16: -208d, 5 → 10
 Day / Week               #47           #48           #49
-------------------- ------------- ------------- -------------
 Sunday                    2            10             -
 Monday                    6            10             9
 Tuesday                   3            10             8
 Wednesday                10             3             9
 Thursday                 10             7            10
 Friday                   10             4            10
 Saturday                 10             -             7
-------------------- ------------- ------------- -------------
 Contributions are on the range from 2022-11-20 to 2022-12-10
```
