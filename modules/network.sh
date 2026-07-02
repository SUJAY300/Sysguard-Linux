#!/bin/bash

get_local_ip(){ hostname -I | awk '{print $1}'; }
get_internet_status(){
if ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
echo "Connected"
else
echo "Disconnected"
fi
}
