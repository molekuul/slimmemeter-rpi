#!/bin/bash
DIR="/var/www/rrdpower"
INPOWER_COLOR="#B5B690"
OTPOWER_COLOR="#3B3131"
rrdtool graph $DIR/power_hourly.png --start -1h DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_daily.png --start -1d DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_weekly.png --start -1w DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_monthly.png --start -1m DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
rrdtool graph $DIR/power_yearly.png --start -1y DEF:powerin=$DIR/power.rrd:powerin:AVERAGE AREA:powerin$INPOWER_COLOR:"Ingaande stroom [W]" \
DEF:powerout=$DIR/power.rrd:powerout:AVERAGE LINE1:powerout$OTPOWER_COLOR:"Uitgaande stroom [W]"
