#!/usr/bin/env bash

##############################################
# Terminal Helpers
##############################################

print_header() {
    printf "\n=========================================\n"
    printf "%s\n" "$1"
    printf "=========================================\n"
}

print_section() {
    printf "\n[%s]\n" "$1"
}

print_key_value() {
    printf "%-25s : %s\n" "$1" "$2"
}

separator() {
    printf "-----------------------------------------\n"
}

##############################################
# Validation
##############################################

directory_exists() {
    [[ -d "$1" ]]
}

file_exists() {
    [[ -f "$1" ]]
}

create_directory() {
    mkdir -p "$1"
}

##############################################
# Date Helpers
##############################################

current_timestamp() {
    date +"$REPORT_TIMESTAMP_FORMAT"
}

##############################################
# Report Helpers
##############################################

report_filename() {
    printf "%s/report_%s.txt" \
        "$REPORT_DIRECTORY" \
        "$(current_timestamp)"
}