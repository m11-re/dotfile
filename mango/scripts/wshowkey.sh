#!/usr/bin/bash
# This script checks if clash is running and kills it if yes, or starts it if no

# Get the process ID of clash
pid=$(pgrep wshowkey)

echo $pid

# If pid is not empty, then clash is running
if [ -n "$pid" ]; then
	# Kill clash using pkill
	echo "$pid" | xargs kill -9
	notify-send --icon=$HOME/tool/screenkey.png --urgency=low "Wshowkey Switch" "wshowkey turned off!"
	# Print a message
	# echo "Clash was running and has been killed."
else
	# Start clash using nohup and &
	# nohup wshowkeys -a bottom -a right -F 'Maple Mono Bold 30' -t 1000 -s '#73e155ff' -f  '#ecd29cff' -b '#3c3423ff' -l 40 >> /dev/null 2<&1 &
	nohup wshowkeys -a bottom -F 'Sans Bold 30' -s '#B5B520ff' -f  '#ecd29cff' -b '#201B1488' -l 60 >> /dev/null 2<&1 &
	# Print a message
	notify-send --icon=$HOME/tool/screenkey.png --urgency=low "Wshowkeysh Switch" "wshowkey turned on!"
	# echo "Clash was not running and has been started."
fi
