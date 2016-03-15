#!/bin/bash
# verwijderen van oude backups (laat de laatste 4 files staan)
/bin/ls /root/dump*gz | /usr/bin/head -n-4 | /usr/bin/xargs rm

# Maak een nieuwe backup
/usr/bin/mysqldump p1db | /bin/gzip -9 > dump_p1db-$( date '+%Y-%m-%d_%H-%M-%S' ).sql.gz

