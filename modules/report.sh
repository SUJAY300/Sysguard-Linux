#!/bin/bash

print_header() {

    printf "\n"
    printf "=============================================\n"
    printf "               SYSGUARD v0.1\n"
    printf "=============================================\n\n"

}

print_field() {

    local label="$1"
    local value="$2"

    printf "%-15s : %s\n" "$label" "$value"

}

print_cpu_header() {
    printf "\n"
    printf "=============================================\n"
    printf "               CPU Info\n"
    printf "=============================================\n\n"
}
