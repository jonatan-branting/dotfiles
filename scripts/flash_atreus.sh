#! /bin/bash

ORG=$(pwd)
cd $HOME/planck/qmk_firmware/keyboards/atreus/
sudo make nonah
cd $HOME/planck/qmk_firmware/.build/
avrdude -p atmega32u4 -c avr109 -U flash:w:atreus_nonah.hex -P /dev/ttyACM0
avrdude -p atmega32u4 -c avr109 -U flash:w:atreus_nonah.hex -P /dev/ttyACM1
cd $ORG

