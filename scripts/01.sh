#!/bin/bash

cat /etc/passwd | awk -F: '{print "\n ========================"} {print "  LOGIN: " $1} {print "  UID: "$3} {print "  PATH: " $6}'
