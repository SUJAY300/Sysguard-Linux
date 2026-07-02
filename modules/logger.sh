#!/bin/bash

LOG_FILE="logs/sysguard.log"

log_message() {
    mkdir -p logs
    printf "[%s] %s\n" "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}
