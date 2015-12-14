#!/bin/bash

#Check input.
if [[ -z $1 || -z $2 || -z $3 ]]; then
  echo "Invalid input: ./calcload.sh $1 $2 $3"
  echo "Correct input is: ./calcload.sh <time> <precision> <pid>."
  exit -1
fi

# Initiate variables.
COUNTER=0
CPU=0
MEM=0
LOOPS=$(expr $1 / $2)

# Calculate average load CPU and MEM utilization.
while [[ $COUNTER -lt $LOOPS ]]; do
  COUNTER=$(bc <<< "$COUNTER+1")
  PROCS=$(top -b -d 1 -n 1 | grep $3)
  
  TEMPC=0
  TEMPCPU=0
  TEMPMEM=0
  #Inner loop, get all processes using filter.
  while [[ $TEMPC -lt $(echo "$PROCS" | wc -l) ]]; do
    TEMPC=$(bc <<< "$TEMPC+1")
    
    #Get line.
    LINE=$(echo "$PROCS" | head -n $TEMPC | tail -n 1)
    
    # Add the information.
    TEMPCPU=$(bc <<< "scale=4;$TEMPCPU+$(echo $LINE | awk '{print $7}')")
    TEMPMEM=$(bc <<< "scale=4;$TEMPMEM+$(echo $LINE | awk '{print $8}')")
  done
  
  # Finally add back to the "real" CPU & MEM.
  CPU=$(bc <<< "scale=4;$CPU+$TEMPCPU")
  MEM=$(bc <<< "scale=4;$MEM+$TEMPMEM")
  sleep $2
done

# Do output.
echo "CPU: "$(bc <<< "scale=4;$CPU/($LOOPS*$(nproc))") 
echo "MEM: "$(bc <<< "scale=4;$MEM/$LOOPS")
