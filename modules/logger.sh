#!/usr/bin/env bash

LOG_LEVEL_INFO="INFO"
LOG_LEVEL_WARN="WARN"
LOG_LEVEL_ERROR="ERROR"

log_message() {
    local level="$1"
    local message="$2"

    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    mkdir -p "$LOG_DIRECTORY"

    printf "[%s] [%s] %s\n" \
        "$timestamp" \
        "$level" \
        "$message" \
        | tee -a "${LOG_DIRECTORY}/${LOG_FILE}" >/dev/null
}

log_info() {
    log_message "$LOG_LEVEL_INFO" "$1"
}

log_warn() {
    log_message "$LOG_LEVEL_WARN" "$1"
}

log_error() {
    log_message "$LOG_LEVEL_ERROR" "$1"
}