#!/bin/bash

get_memory_total(){ free -h | awk '/Mem:/ {print $2}'; }
get_memory_used(){ free -h | awk '/Mem:/ {print $3}'; }
get_memory_free(){ free -h | awk '/Mem:/ {print $4}'; }
