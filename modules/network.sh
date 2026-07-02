#!/bin/bash

get_local_ip(){ hostname -I | awk '{print $1}'; }
get_internet_status() {

    if ! command -v ping >/dev/null 2>&1; then
        echo "Unavailable"
        return
    fi

    if ping -c 1 -W 1 "$PING_HOST" >/dev/null 2>&1; then
        echo "Connected"
    else
        echo "Disconnected"
    fi
}
