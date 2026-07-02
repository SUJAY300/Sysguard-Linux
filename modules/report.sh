#!/bin/bash

print_header() {

    printf "\n"
    printf "=============================================\n"
    printf "               SYSGUARD v0.3\n"
    printf "=============================================\n\n"

}

print_field() {

    local label="$1"
    local value="$2"

    printf "%-15s : %s\n" "$label" "$value"

}

generate_report_name() {
    date +"${REPORT_DIRECTORY}/report_%Y-%m-%d_%H-%M-%S.txt"
}

save_report() {
    local report_file="$1"

    {
        print_header

        print_field "Hostname" "$HOSTNAME"
        print_field "User" "$CURRENT_USER"
        print_field "Date" "$CURRENT_DATE"
        print_field "Kernel" "$KERNEL"
        print_field "Architecture" "$ARCHITECTURE"
        print_field "Shell" "$SHELL_NAME"
        print_field "Uptime" "$UPTIME"

        print_field "CPU Health" "$CPU_STATUS"
        print_field "CPU Model" "$CPU_MODEL"
        print_field "CPU Cores" "$CPU_CORES"
        print_field "CPU Usage" "$CPU_USAGE"

        print_field "Memory Health" "$MEMORY_STATUS"
        print_field "Memory Total" "$MEMORY_TOTAL"
        print_field "Memory Used" "$MEMORY_USED"
        print_field "Memory Free" "$MEMORY_FREE"

        print_field "Disk Health" "$DISK_STATUS"
        print_field "Disk Usage" "$DISK_USAGE"
        print_field "Disk Free" "$DISK_FREE"

        print_field "Local IP" "$LOCAL_IP"
        print_field "Internet" "$INTERNET"

        printf "\n"

        printf "========== Top CPU Processes ==========\n"
        printf "%s\n" "$TOP_CPU_PROCESSES"

        printf "\n"

        printf "======== Top Memory Processes ========\n"
        printf "%s\n" "$TOP_MEMORY_PROCESSES"

    } > "$report_file"

    log_info "Report saved: $report_file"
}