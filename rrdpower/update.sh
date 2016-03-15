#/usr/bin/rrdtool update /var/www/rrdtemp/hometemp.rrd N:$temp:$outtemp
powerin=`/bin/grep "afgenomen vermogen" /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $3}'`
powerout=`/bin/grep "teruggeleverd vermogen" /home/gej/P1uitlezer.txt | /usr/bin/awk '{print "-",$3}'`


/usr/bin/rrdtool update /var/www/rrdpower/power.rrd N:$powerin:$powerout
