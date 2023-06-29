#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p backup

#set date
printf -v date '%(%Y-%m-%d)T' -1
file="backup/mcbackup-$date.tar.gz"

echo "*** Using RCON to stop the server gracefully"
docker run --rm --network host itzg/rcon-cli --password rcon stop
echo "*** Giving the server time to save everything"
sleep 20
echo "*** Stopping server, just in case it couldn't stop in 20 seconds"
docker compose stop

echo "*** Archiving server folder to $file"
nice tar cvaf "$file" server

echo "*** Backup completed"

echo "*** Starting server again"
docker compose start