#!/usr/bin/env bash

get_top_cpu_processes() {
    ps -eo pid,user,%cpu,comm --sort=-%cpu | head -n 6
}

get_top_memory_processes() {
    ps -eo pid,user,%mem,comm --sort=-%mem | head -n 6
}