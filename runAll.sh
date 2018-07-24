#!/bin/bash

MAX_JOBS=4

echo "Starting:"
for n in 5 6; do
	while [[ $MAX_JOBS -le $(jobs -l | wc -l) ]]; do sleep 0.1; done
	(
		echo "  start $n →"
		./tankPlot.py -n $n -sq 1>/dev/null
		./tankPlot.py -n $n -rq 1>/dev/null
		echo "    止 end $n"
	) &
done
for n in 1 2 3 4 11 12 13 14; do
	while [[ $MAX_JOBS -le $(jobs -l | wc -l) ]]; do sleep 0.1; done
	(
		echo "  start $n →"
		./tankPlot.py -n $n --subplot -sq 1>/dev/null
		./tankPlot.py -n $n --subplot -rq 1>/dev/null
		echo "    止 end $n"
	) &
done

while [[ $(jobs -lr | wc -l) -gt 0 ]]; do sleep 0.1; done
echo "DONE!"
