#!/bin/bash

health_status() {
    local value=$1
    local warn=$2
    local crit=$3

    value=${value%\%}
    value=${value%.*}

    if [ $value -ge $crit ]; then
        echo "CRITICAL"
    elif [ $value -ge $warn ]; then
        echo "WARNING"
    else
        echo "HEALTHY"
    fi
}
