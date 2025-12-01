---
id: 318
database_id: 1267077296
node_id: I_kwDOCTsueM5LhhCw
status: open
title: "command: domain to check availability"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/318
created_at: 2022-06-10T06:07:12Z
updated_at: 2022-08-14T18:54:08Z
---

# command: domain to check availability

**Motivation:** there is no way to check new domain name availability.

**PoC**

```bash
$ domain tact
# loop for (.com, .net, etc)
# dig +noall +answer domain
# nslookup domain >/dev/null
```

**List**

- com, 1350
- me, 880
- tv, 4945
- org, 1595
- world, 2395
- cc, 2795
- net, 1595
- biz, 2195
- center, 1595
- info, 895
- city, 1755

- online, 2990
- site, 295
- plus, 3515
- tech, 595
- website, 1835
- cloud, 2395
- net, 1595
- space, 595
- blog, 3275

- shop, 3500
- group, 1595
- agency, 1650
- pro, 1075
- vip, 1870
- company, 1595
- market, 2395
- top, 690
- ltd, 2555
- realty, 43675

- club, 1595
- dance, 2635
- fashion, 3355
- tv, 4945
- school, 3515
- design, 5545
- fun, 1835
- today, 2555
- cafe, 3515
- art, 355
- academy, 3515
- xyz, 295

**To do**

- [ ] port this feature into the `check` project
