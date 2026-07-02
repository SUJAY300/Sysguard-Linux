#!/usr/bin/env bash

##############################################
# SysGuard v0.5
##############################################

set -Eeuo pipefail

##############################################
# Project Root
##############################################

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

##############################################
# Load Configuration
##############################################

source "${PROJECT_ROOT}/config/thresholds.conf"

##############################################
# Load Modules
##############################################

source "${PROJECT_ROOT}/modules/system.sh"
source "${PROJECT_ROOT}/modules/report.sh"
source "${PROJECT_ROOT}/modules/cpu.sh"
source "${PROJECT_ROOT}/modules/memory.sh"
source "${PROJECT_ROOT}/modules/disk.sh"
source "${PROJECT_ROOT}/modules/network.sh"
source "${PROJECT_ROOT}/modules/logger.sh"
source "${PROJECT_ROOT}/modules/health.sh"
source "${PROJECT_ROOT}/modules/process.sh"

##############################################
# CLI Arguments
##############################################

WATCH_MODE=false
WATCH_INTERVAL=5
GENERATE_REPORT=false
GENERATE_JSON=false
GENERATE_CSV=false

show_help() {

cat << EOF

SysGuard v0.3

Usage:

./sysguard.sh [OPTION]

Options

--help          Show help
--version       Show version
--report        Save report
--json          Save JSON report
--csv           Save CSV report
--watch <sec>   Refresh every n seconds

EOF

}

while [[ $# -gt 0 ]]
do
    case "$1" in

        --help)
            show_help
            exit 0
            ;;

        --version)
            echo "SysGuard v0.5"
            exit 0
            ;;

        --report)
            GENERATE_REPORT=true
            shift
            ;;

        --json)
            GENERATE_JSON=true
            shift
            ;;

        --csv)
            GENERATE_CSV=true
            shift
            ;;


        --watch)
            WATCH_MODE=true
            WATCH_INTERVAL="$2"

            if [[ $# -lt 2 ]]; then
                echo "Error: --watch requires an interval."
                exit 1
            fi

            if ! [[ "$WATCH_INTERVAL" =~ ^[0-9]+$ ]]; then
                echo "Error: Watch interval must be a positive integer."
                exit 1
            fi            

            shift 2
            ;;

        *)
            echo "Unknown option: $1"
            exit 1
            ;;

    esac
done

##############################################
# Prepare Directories
##############################################

mkdir -p "$LOG_DIRECTORY"
mkdir -p "$REPORT_DIRECTORY"

log_info "SysGuard started."

collect_data() {
    ##############################################
    # System Information
    ##############################################

    HOSTNAME=$(get_hostname)
    CURRENT_USER=$(get_current_user)
    CURRENT_DATE=$(get_current_date)
    KERNEL=$(get_kernel_version)
    ARCHITECTURE=$(get_architecture)
    SHELL_NAME=$(get_shell_name)
    UPTIME=$(get_uptime)

    ##############################################
    # CPU
    ##############################################

    CPU_MODEL=$(get_cpu_model)
    CPU_CORES=$(get_cpu_cores)
    CPU_USAGE=$(get_cpu_usage)
    CPU_STATUS=$(health_status "$CPU_USAGE" "$CPU_WARNING" "$CPU_CRITICAL")

    ##############################################
    # Memory
    ##############################################

    MEMORY_TOTAL=$(get_memory_total)
    MEMORY_USED=$(get_memory_used)
    MEMORY_FREE=$(get_memory_free)
    MEMORY_PERCENT=$(free | awk '/Mem:/ {printf("%.0f%%",$3/$2*100)}')
    MEMORY_STATUS=$(health_status "$MEMORY_PERCENT" "$MEMORY_WARNING" "$MEMORY_CRITICAL")

    ##############################################
    # Disk
    ##############################################

    DISK_USAGE=$(get_disk_usage)
    DISK_FREE=$(get_disk_free)
    DISK_STATUS=$(health_status "$DISK_USAGE" "$DISK_WARNING" "$DISK_CRITICAL")

    ##############################################
    # Network
    ##############################################

    LOCAL_IP=$(get_local_ip)
    INTERNET=$(get_internet_status)

    ##############################################
    # Processes
    ##############################################

    TOP_CPU_PROCESSES=$(get_top_cpu_processes)
    TOP_MEMORY_PROCESSES=$(get_top_memory_processes)
}

##############################################
# Output
##############################################

display_dashboard() {
    print_header

    print_field "Hostname"       "$HOSTNAME"
    print_field "User"           "$CURRENT_USER"
    print_field "Date"           "$CURRENT_DATE"
    print_field "Kernel"         "$KERNEL"
    print_field "Architecture"   "$ARCHITECTURE"
    print_field "Shell"          "$SHELL_NAME"
    print_field "Uptime"         "$UPTIME"

    print_field "CPU Health"     "$CPU_STATUS"
    print_field "CPU Model"      "$CPU_MODEL"
    print_field "CPU Cores"      "$CPU_CORES"
    print_field "CPU Usage"      "$CPU_USAGE"

    print_field "Memory Health"  "$MEMORY_STATUS"
    print_field "Memory Total"   "$MEMORY_TOTAL"
    print_field "Memory Used"    "$MEMORY_USED"
    print_field "Memory Free"    "$MEMORY_FREE"

    print_field "Disk Health"    "$DISK_STATUS"
    print_field "Disk Usage"     "$DISK_USAGE"
    print_field "Disk Free"      "$DISK_FREE"

    print_field "Local IP"       "$LOCAL_IP"
    print_field "Internet"       "$INTERNET"

    printf "\n"

    printf "========== Top CPU Processes ==========\n"
    printf "%s\n" "$TOP_CPU_PROCESSES"

    printf "\n"

    printf "======== Top Memory Processes =========\n"
    printf "%s\n" "$TOP_MEMORY_PROCESSES"
}

##############################################
# Execution
##############################################

if $WATCH_MODE
then
    while true
    do
        clear
        collect_data
        display_dashboard
        sleep "$WATCH_INTERVAL"
    done

    exit 0
fi

# Normal execution
collect_data
display_dashboard

# Optional report
if $GENERATE_REPORT
then
    REPORT_FILE=$(generate_report_name)
    save_report "$REPORT_FILE"

    printf "\n"
    printf "Report saved to: %s\n" "$REPORT_FILE"
fi

if $GENERATE_JSON
then
    generate_json_report
fi

if $GENERATE_CSV
then
    generate_csv_report
fi

log_info "SysGuard execution completed."

printf "\n"
printf "SysGuard execution completed successfully.\n"