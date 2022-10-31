#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p backup

#set date
printf -v date '%(%Y-%m-%d)T' -1
file="backup/mcbackup-$date.tar"

docker compose stop
nice tar cvaf "$file" server
#time nice gzip -fk1 "$file"
#time nice lz4 -fk1 "$file" 
#time nice lzop -fk1 "$file"
#time nice zstd -fk1 "$file" 
#nice tar -c --use-compress-program=pigz -f "$file" server
docker compose start
