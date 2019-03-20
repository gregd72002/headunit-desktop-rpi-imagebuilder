#!/bin/bash

stty -F /dev/ttyUSB1 speed 9600 cs8 -cstopb -parenb
echo -n -e '\xA0\x01\x01\xA2' > /dev/ttyUSB1
sleep 3;
echo -n -e '\xA0\x01\x00\xA1' > /dev/ttyUSB1

echo "DONE"

