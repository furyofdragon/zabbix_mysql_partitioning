#!/bin/bash

TS=`date +%Y-%m-%d-%H-%M`
echo $TS

ZDB2=zabbix
TL=( `echo "SHOW TABLES" | mysql $ZDB2 | egrep -v "Tables_in_|acknowledges|alerts|auditlog|auditlog_details|escalations|event_recovery|event_tag|events|history|housekeeper|problem|problem_tag|sessions|trends"` )

sudo ionice -c3 mysqldump --single-transaction zabbix `echo ${TL[@]}` | gzip > /opt/backup/zabbix/zabbix-metadata.$TS.sql.gz
