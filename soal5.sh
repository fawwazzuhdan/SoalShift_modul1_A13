#!/bin/bash

cd ~/SISOP/modul1/SoalShift_modul1_A13

awk 'BEGIN{IGNORECASE=1} (!/sudo/ && (/cron/ || /CRON/) ) { if (NF < 13) print $0}' /var/log/syslog > ~/SISOP/modul1/logs.txt