#!/bin/sh

echo "${PERIODICITY} LANG=${LANG} owncloudcmd --silent --non-interactive -n --exclude /conf/sync-exclude.lst /data ${SERVER} > /log/csync.log.\`date -Iseconds\` 2>&1" | crontab -
crond -f -d 8
