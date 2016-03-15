#!/bin/bash
DIR="/var/www/rrdpower"
INPOWER_COLOR="#B5B690"
OTPOWER_COLOR="#3B3131"

##rrdtool graph $DIR/power_hourly.png --start -1h 
#DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
##DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"


rrdtool graph powerday.png \
--start=-1d \
--end=now \
--title="Power input - output" \
--imgformat=PNG \
--width=800 \
--base=1000 \
--height=220 \
--alt-autoscale \
--interlaced \
DEF:a=$DIR/power.rrd:powerin:AVERAGE \
LINE2:a#FFA500:powerout \
DEF:b=$DIR/power.rrd:powerout:AVERAGE \
LINE2:b#FFA500:powerout \
DEF:temperature=$DIR/power.rrd:powerin:AVERAGE \
GPRINT:temperature:LAST:"Ingaand vermogen.\: %.0lfWatt\r"

#http://stackoverflow.com/questions/5693727/how-to-make-two-lines-appear-on-the-same-height-in-rrdtool

##VDEF:a_MIN=a,MINIMUM \
##GPRINT:a_MIN:Min\: %8.2lf%s
#VDEF:powerin_AVERAGE=a,AVERAGE \
#GPRINT:powerin_AVERAGE:Avg\: %8.2lf%s \
#VDEF:powerin_MAX=powerin,MAXIMUM \
#GPRINT:powerin_MAX:Max\: %8.2lf%s \
#VDEF:powerin_LAST=powerin,LAST \
#GPRINT:powerin_LAST:Last\: %8.2lf%s\n \
#LINE3:powerout#FF0000:powerout AVERAGE \
#VDEF:powerout_MIN=powerout,MINIMUM \
#GPRINT:powerout_MIN:Min\: %8.2lf%s \
#VDEF:powerout_AVERAGE=powerout,AVERAGE \
#GPRINT:powerout_AVERAGE:Avg\: %8.2lf%s \
#VDEF:powerout_MAX=powerout,MAXIMUM \
#GPRINT:powerout_MAX:Max\: %8.2lf%s \
#VDEF:powerout_LAST=powerout,LAST \
#GPRINT:powerout_LAST:Last\: %8.2lf%s\n \
#COMMENT:"Wed 2012-05-02 14\:11 - Thu 2012-05-03 14\:11\c" \
#COMMENT:"Created onThu 2012-05-03 14\:11"\r


##rrdtool graph $DIR/power_daily.png --start -1d DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
##DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
##rrdtool graph $DIR/power_weekly.png --start -1w DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
##DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
##rrdtool graph $DIR/power_monthly.png --start -1m DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
##DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
##rrdtool graph $DIR/power_yearly.png --start -1y DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
##DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
