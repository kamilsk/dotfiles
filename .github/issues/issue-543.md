---
id: 543
database_id: 1632695885
node_id: I_kwDOCTsueM5hUPZN
status: closed
title: "git: suggest doesn't work properly"
labels: [type: bug, severity: critical, scope: code, impact: high, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/543
created_at: 2023-03-20T19:00:18Z
updated_at: 2023-04-04T16:04:28Z
---

# git: suggest doesn't work properly

**Bad case**

If a suggestion for the first part of the week, but the latest state of git related to the second part.

```bash
$  Day / Week   #1   #2   #3   #4   #5   #6   #7   #8   #9   #10   #11 
------------ ---- ---- ---- ---- ---- ---- ---- ---- ---- ----- -----
 Sunday       9    8    3    5    9    6    6    6    6     4     5  
 Monday       9    8    5    6    9    6    6    5    6     5     5  
 Tuesday      9    8    5    5    9    6    6    6    6     7     5  
 Wednesday    9    8    5    5    5    1    5    6    3     5     5  
 Thursday     9    8    5    6    4    1    6    6    6     5     5  
 Friday       9    8    5    6    9    5    5    6    6     5     5  
 Saturday     9    8    5    6    9    10   6    6    5     5     5  
------------ ---- ---- ---- ---- ---- ---- ---- ---- ---- ----- -----
 Contributions are on the range from 2022-01-02 to 2022-03-19        
[main 865cecc] fake
 Date: Sat Feb 12 13:00:23 2022 +0300
```

Expected: Feb 16 (5->6) instead of Feb 12 (10->?). It is because it suggested Feb 8 (6->10) for the week.
