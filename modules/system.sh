#!/bin/bash

# ==========================================
# System Information Module
# ==========================================

get_hostname() {
    hostname | tr '[:lower:]' '[:upper:]'
}

get_current_user() {
    whoami
}

get_current_date() {
    date "+%Y-%m-%d %H:%M:%S"
}

get_kernel_version() {
    uname -r
}

get_architecture() {
    uname -m
}

get_uptime() {
    uptime
}
