#!/bin/bash
sleep 30
# 1 keer per 5 minuten, uitlezen via seriele interface van de slimme meter
su - gej -c "python /home/gej/P1uitlezer.py > /home/gej/P1uitlezer.txt" 2>&1 >/dev/null

# hierna is /home/gej/P1uitlezer.txt het bestand waar we mee verder werken.
cat /home/gej/P1uitlezer.txt >> /tmp/logging.txt
echo `time` >> /tmp/logging.txt

#########################################################################################
# extraheren gas en bijwerken rrd
#########################################################################################
gas=`/bin/grep Gas /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $2}'`
/usr/bin/rrdtool update /var/www/rrdgas/homegas.rrd N:$gas

#########################################################################################
# temperatuur
#########################################################################################
temp=`/opt/vc/bin/vcgencmd measure_temp | /usr/bin/cut -c6-9`
outtemp=`/usr/bin/python /home/gej/get1temp.py 10-000801609604`
/usr/bin/rrdtool update /var/www/rrdtemp/hometemp.rrd N:$temp:$outtemp

# Update rrdtemp
DIR="/var/www/rrdtemp"
INTEMP_COLOR="#B5B690"
OTTEMP_COLOR="#3B3131"
/usr/bin/rrdtool graph $DIR/temp_hourly.png --start -1h DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"
/usr/bin/rrdtool graph $DIR/temp_daily.png --start -1d DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"
#/usr/bin/rrdtool graph $DIR/temp_daily.png --start -1d DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
#DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"
/usr/bin/rrdtool graph $DIR/temp_weekly.png --start -1w DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"
/usr/bin/rrdtool graph $DIR/temp_monthly.png --start -1m DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"
/usr/bin/rrdtool graph $DIR/temp_yearly.png --start -1y DEF:temp=$DIR/hometemp.rrd:temp:AVERAGE LINE1:temp$INTEMP_COLOR:"Inside Temperature [deg C]" \
DEF:outtemp=$DIR/hometemp.rrd:outtemp:AVERAGE LINE1:outtemp$OTTEMP_COLOR:"Outside Temperature [deg C]"

# bijwerken png voor rrdgas
DIR="/var/www/rrdgas"
GAS_COLOR="#B5B690"
/usr/bin/rrdtool graph $DIR/gas_hourly.png --start -1h DEF:gas=$DIR/homegas.rrd:gas:AVERAGE AREA:gas$GAS_COLOR:"Gas gebruik in dm3"
/usr/bin/rrdtool graph $DIR/gas_daily.png --start -1d DEF:gas=$DIR/homegas.rrd:gas:AVERAGE AREA:gas$GAS_COLOR:"Gas gebruik in dm3" 
/usr/bin/rrdtool graph $DIR/gas_weekly.png --start -1w DEF:gas=$DIR/homegas.rrd:gas:AVERAGE AREA:gas$GAS_COLOR:"Gas gebruik in dm3" 
/usr/bin/rrdtool graph $DIR/gas_monthly.png --start -1m DEF:gas=$DIR/homegas.rrd:gas:AVERAGE AREA:gas$GAS_COLOR:"Gas gebruik in dm3"
/usr/bin/rrdtool graph $DIR/gas_yearly.png --start -1y DEF:gas=$DIR/homegas.rrd:gas:AVERAGE AREA:gas$GAS_COLOR:"Gas gebruik in dm3"

#####################################################################################
# Bijwerken stroomverbruik
#####################################################################################
powerin=`/bin/grep Afgenomen /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $3}'`
powerout="-`/bin/grep Teruggeleverd /home/gej/P1uitlezer.txt | /usr/bin/awk '{print $3}'`"
/usr/bin/rrdtool update /var/www/rrdpower/power.rrd N:$powerin:$powerout

DIR="/var/www/rrdpower"
INPOWER_COLOR="#B5B690"
OTPOWER_COLOR="#3B3131"
rrdtool graph $DIR/power_hourly.png --start -1h DEF:powerin=$DIR/power.rrd:powerin:AVERAGE LINE1:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_daily.png --start -1d DEF:powerin=$DIR/power.rrd:powerin:AVERAGE LINE1:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_weekly.png --start -1w DEF:powerin=$DIR/power.rrd:powerin:AVERAGE LINE1:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_monthly.png --start -1m DEF:powerin=$DIR/power.rrd:powerin:AVERAGE LINE1:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_yearly.png --start -1y DEF:powerin=$DIR/power.rrd:powerin:AVERAGE LINE1:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"

