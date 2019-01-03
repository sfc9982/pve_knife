#!/bin/bash
get_char() {
    SAVEDSTTY=$(stty -g)
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty "$SAVEDSTTY"
}

UpdateRepo() {
    apt clean all
    apt update 
}

UpgradeSoftware() {
    apt upgrade -y
}



#### Start Script

cat << EOF
********Welcome to use Knife of PVE**   
********please enter your choise:****
(1) Optimize your Proxmox
(2) Download ISO
(3) Install Docker
(4) Update System
(5) Nope
(6) Exit Menu
EOF
read input
case $input in
    1)
    . func/Optimize.sh
    BoostNow
    ;;
    2)
    funcX
    ;;
    3)
    funcX
    ;;
    4)
    funcX
    ;;
    9)
    exit
    ;;
esac
