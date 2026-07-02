#!/bin/bash

source modules/system.sh
source modules/report.sh
source modules/cpu.sh
source modules/memory.sh
source modules/disk.sh
source modules/network.sh

HOSTNAME=$(get_hostname)
CURRENT_USER=$(get_current_user)
CURRENT_DATE=$(get_current_date)
KERNEL=$(get_kernel_version)
ARCHITECTURE=$(get_architecture)
SHELL_NAME=$(get_shell_name)
UPTIME=$(get_uptime)

CPU_MODEL=$(get_cpu_model)
CPU_CORES=$(get_cpu_cores)
CPU_USAGE=$(get_cpu_usage)

MEMORY_TOTAL=$(get_memory_total)
MEMORY_USED=$(get_memory_used)
MEMORY_FREE=$(get_memory_free)

DISK_USAGE=$(get_disk_usage)
DISK_FREE=$(get_disk_free)

LOCAL_IP=$(get_local_ip)
INTERNET=$(get_internet_status)

print_header

print_field "Hostname" "$HOSTNAME"
print_field "User" "$CURRENT_USER"
print_field "Date" "$CURRENT_DATE"
print_field "Kernel" "$KERNEL"
print_field "Architecture" "$ARCHITECTURE"
print_field "Shell" "$SHELL_NAME"
print_field "Uptime" "$UPTIME"

print_field "CPU Model" "$CPU_MODEL"
print_field "CPU Cores" "$CPU_CORES"
print_field "CPU Usage" "$CPU_USAGE"

print_field "Memory Total" "$MEMORY_TOTAL"
print_field "Memory Used" "$MEMORY_USED"
print_field "Memory Free" "$MEMORY_FREE"

print_field "Disk Usage" "$DISK_USAGE"
print_field "Disk Free" "$DISK_FREE"

print_field "Local IP" "$LOCAL_IP"
print_field "Internet" "$INTERNET"
