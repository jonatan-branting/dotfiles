#!/bin/bash

#Check input.
if [[ -z $1 || -z $2 ]]; then
  echo "Invalid input: ./calcload.sh $1 $2"
  echo "Correct input is: ./calcload.sh <time> <precision>."
  exit -1
fi

# Initiate variables.
COUNTER=0
LOADAVG=0
LOOPS=$(expr $1 / $2)

# Calculate average load CPU and MEM utilization.
while [[ $COUNTER -lt $LOOPS ]]; do
  COUNTER=$(bc <<< "$COUNTER+1")
  LOADAVG=$(bc <<< "$LOADAVG+$(cat /proc/loadavg | awk '{print $1}')")
  sleep $2
done

# Do output.
echo "LOADAVG: "$(bc <<< "scale=4;($LOADAVG/$LOOPS)*(100/$(nproc))")%
