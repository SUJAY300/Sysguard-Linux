#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

print_header() {

    printf "\n"
    printf "=============================================\n"
    printf "               SYSGUARD v0.5\n"
    printf "    Linux Monitoring & Automation Toolkit\n"
    printf "=============================================\n\n"

}

print_field() {

    local label="$1"
    local value="$2"

    printf "%-15s : %s\n" "$label" "$value"

}

format_health() {

    case "$1" in
        HEALTHY)
            printf "${GREEN}%s${RESET}" "$1"
            ;;
        WARNING)
            printf "${YELLOW}%s${RESET}" "$1"
            ;;
        CRITICAL)
            printf "${RED}%s${RESET}" "$1"
            ;;
        *)
            printf "%s" "$1"
            ;;
    esac

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

        print_field "CPU Health" "$(format_health "$CPU_STATUS")"
        print_field "CPU Model" "$CPU_MODEL"
        print_field "CPU Cores" "$CPU_CORES"
        print_field "CPU Usage" "$CPU_USAGE"

        print_field "Memory Health" "$(format_health "$MEMORY_STATUS")"
        print_field "Memory Total" "$MEMORY_TOTAL"
        print_field "Memory Used" "$MEMORY_USED"
        print_field "Memory Free" "$MEMORY_FREE"

        print_field "Disk Health" "$(format_health "$DISK_STATUS")"
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

        print_field "Generated At" "$(date)"

    } > "$report_file"

    log_info "Report saved: $report_file"
}

generate_json_report() {

    local json_file="${REPORT_DIRECTORY}/report_$(date +%Y-%m-%d_%H-%M-%S).json"

    cat > "$json_file" <<EOF
{
    "hostname": "$HOSTNAME",
    "user": "$CURRENT_USER",
    "date": "$CURRENT_DATE",
    "kernel": "$KERNEL",
    "architecture": "$ARCHITECTURE",
    "shell": "$SHELL_NAME",
    "uptime": "$UPTIME",

    "cpu": {
        "model": "$CPU_MODEL",
        "cores": "$CPU_CORES",
        "usage": "$CPU_USAGE",
        "status": "$CPU_STATUS"
    },

    "memory": {
        "total": "$MEMORY_TOTAL",
        "used": "$MEMORY_USED",
        "free": "$MEMORY_FREE",
        "status": "$MEMORY_STATUS"
    },

    "disk": {
        "usage": "$DISK_USAGE",
        "free": "$DISK_FREE",
        "status": "$DISK_STATUS"
    },

    "network": {
        "local_ip": "$LOCAL_IP",
        "internet": "$INTERNET"
    }
}
EOF

    log_info "JSON report generated: $json_file"

    printf "\nJSON report saved to: %s\n" "$json_file"
}

generate_csv_report() {

    local csv_file="${REPORT_DIRECTORY}/report_$(date +%Y-%m-%d_%H-%M-%S).csv"

    {
        echo "Field,Value"

        echo "Hostname,$HOSTNAME"
        echo "User,$CURRENT_USER"
        echo "Date,$CURRENT_DATE"
        echo "Kernel,$KERNEL"
        echo "Architecture,$ARCHITECTURE"
        echo "Shell,$SHELL_NAME"
        echo "Uptime,$UPTIME"

        echo "CPU Model,$CPU_MODEL"
        echo "CPU Cores,$CPU_CORES"
        echo "CPU Usage,$CPU_USAGE"
        echo "CPU Status,$CPU_STATUS"

        echo "Memory Total,$MEMORY_TOTAL"
        echo "Memory Used,$MEMORY_USED"
        echo "Memory Free,$MEMORY_FREE"
        echo "Memory Status,$MEMORY_STATUS"

        echo "Disk Usage,$DISK_USAGE"
        echo "Disk Free,$DISK_FREE"
        echo "Disk Status,$DISK_STATUS"

        echo "Local IP,$LOCAL_IP"
        echo "Internet,$INTERNET"

    } > "$csv_file"

    log_info "CSV report generated: $csv_file"

    printf "\nCSV report saved to: %s\n" "$csv_file"
}