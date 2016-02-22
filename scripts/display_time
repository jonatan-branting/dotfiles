#!/bin/bash

Network() {
  PROFILE=$(netctl list | grep \* | cut -d " " -f 2)$(netctl-auto list | grep \* | cut -d " " -f 2)
  INTERFACE=$(iwlist wlp1s0 scanning | grep wlp1s0 | awk '{print $2}')
  if [[ $INTERFACE == "Scan" ]]
  then
    if [[ -z $PROFILE ]]
    then
      echo "null" 
    else
      echo $PROFILE , $(SignalStrength)%
    fi
  else
    echo "disabled"
  fi
}

SignalStrength() {
  FRACTION=$(iwconfig wlp1s0 | grep -i quality | awk '{print $2}' | cut -d = -f 2 | bc -l)
  echo $(bc <<< "scale=2;$FRACTION*100" | cut -d . -f 1)
}

Clock() {
  echo $(clock | cut -d " " -f 2)
}

Date() {
  echo $(date | cut -d " " -f 2-3)
}

Battery() {
  echo $(cat /sys/class/power_supply/BAT0/capacity)
}

notify-send -t 5500 "Information" "[ $(Network) ]\n[ $(Clock), $(Date) ]\n[ $(Battery)% ]"
