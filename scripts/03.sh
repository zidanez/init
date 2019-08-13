#!/bin/bash
HN=0
SP=0
TCP=0
UDP=0
while getopts "pf:s:tu" optname
        do
                case "$optname" in
                        "p")
                                HN=1
                        ;;
                        "f")
                                FN=$OPTARG
                        ;;
                        "s")
                                SP=$OPTARG
                        ;; 
                        "t")    
                                TCP=1
                        ;;
                        "u")
                                UDP=1
                        ;; 
                esac
        done

if [ $FN ]
        then
                for var in $(cat $FN)
                        do
                                ping -q -c2 -W2 $var > /dev/null
                                if [ $? -eq 0 ]
                                then
                                        if [ $HN -eq 1 ]
                                        then
                                                HOSTNAME=$(host $var | awk NP=1'{print $5}')
                                                echo -e "$var : \033[32m$HOSTNAME\033[0m"
                                        else
                                                echo -e "$var : \033[32mOK\033[0m"
                                        fi
                                        if [ $SP -ne 0 ]
                                        then
                                                if [ $TCP -eq 1 ]
                                                then
                                                        echo "  ===TCP PORTS==="
                                                        for p in $(seq 1 $SP)
                                                                do
                                                                        (echo > /dev/tcp/$var/$p) > /dev/null 2>&1 && echo -e " $p : \033[32mopen\033[0m"
                                                                done
                                                fi
                                                if [ $UDP -eq 1 ]
                                                then
                                                        echo "  ===UDP PORTS==="
                                                        for p in $(seq 1 $SP)
                                                                do
                                                                        (echo > /dev/udp/$var/$p) > /dev/null 2>&1 && echo -e " $p : \033[32mopen\033[0m"
                                                                done
                                                fi
                                        fi
                                else
                                        echo -e "$var : \033[31mFALSE\033[0m"
                                fi
                        done
        else
                echo "No file target"
        fi



