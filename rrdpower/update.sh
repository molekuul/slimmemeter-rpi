#!/bin/bash
# Om er zeker van te zijn dat er geen andere readers lopen, zoals de p1db versie even 30 seconden pauze
sleep 30
# 1 keer per 5 minuten, uitlezen via seriele interface van de slimme meter
su - gej -c "python /home/gej/slimmemeter-rpi/P1uitlezer-DSMR42.py > /home/gej/P1uitlezer.txt" 2>&1 >/dev/null

# hierna is /home/gej/P1uitlezer.txt het bestand waar we mee verder werken.

#/usr/bin/rrdtool update /var/www/html/rrdtemp/hometemp.rrd N:$temp:$outtemp
powerin=`/bin/grep "Afgenomen vermogen" /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $3}'`
powerout=`/bin/grep "Teruggeleverd vermogen" /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $3*-1}'`

echo "powerin ", $powerin

/usr/bin/rrdtool update /var/www/html/rrdpower/power.rrd N:$powerin:$powerout
/var/www/html/rrdpower/create_graphs.sh
