#!/bin/sh

echo "${PERIODICITY} LANG=${LANG} nextcloudcmd --silent --non-interactive -n --davpath ${DAVPATH} --exclude /conf/sync-exclude.lst /data ${SERVER} > /log/csync.log.\`date -Iseconds\` 2>&1" | crontab -
crond -f -d 8
