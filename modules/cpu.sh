#!/bin/bash

get_cpu_model() {
    lscpu | grep "Model name" | cut -d ":" -f2 | xargs
}

get_cpu_cores() {
    nproc
}

get_cpu_usage() {
    top -bn1 | awk -F',' '/Cpu\(s\)/ {gsub(/ id/,"",$4); gsub(/^[[:space:]]+/,"",$4); printf "%.1f%%",100-$4}'
}
