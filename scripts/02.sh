#!/bin/bash

NAME=$(w | grep pts/2 | awk '{print $1}')
TTYS=$(w | grep $NAME | grep pts | awk '{print $2}')
PIDS=$(ps -f -u $NAME | grep -v "PID" | awk NP!=1'{print $2}')

sudo killall -u $NAME && sudo deluser $NAME
