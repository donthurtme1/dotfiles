#!/bin/env bash
lines=$(tput lines)

contents=""
i=0
while IFS= read -r line && [[ $i -lt $lines ]]; do
	i=$((i + 1))
	contents="${contents}${line}
"
done

if [[ $(echo "$contents" | wc -l) -gt $lines ]]; then
	echo "$contents" | vim -R -
else
	echo "$contents" | less
fi
