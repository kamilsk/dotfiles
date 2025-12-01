---
id: 396
database_id: 1345266399
node_id: I_kwDOCTsueM5QLyLf
status: open
title: "bash: extend lookup script by showing comments"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/396
created_at: 2022-08-20T19:18:29Z
updated_at: 2022-08-20T19:18:30Z
---

# bash: extend lookup script by showing comments

```bash
$ lookup datetime
datetime () {
	local iso="%Y-%m-%dT%H:%M:%S%Z"
	local mutator
	mutator=$(echo "${1:-}" | sed 's:\([[:alpha:]]\):\1 :g')
	if [ -z "${mutator}" ]
	then
		date +${iso}
		return
	fi
	if [[ "$mutator" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
	then
		local day=$((24*60*60))
		local now req
		now=$(date +%s)
		req=$(date -jf %Y-%m-%d +%s "${mutator}")
		echo $(((req - now) / day))d
		return
	fi
	local sign=+
	if [[ "${mutator}" == -* ]]
	then
		mutator="${mutator##-}"
		sign=-
	fi
	local v
	for m in $(echo "${mutator}" | cat)
	do
		v+="-v${sign}${m} "
	done
	eval "date -j ${v}+${iso}"
}
```

it doesn't contain comments and sometimes it's difficult to understand what exactly this code meens
