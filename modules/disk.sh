#!/bin/bash

get_disk_usage(){ df -h / | awk 'NR==2{print $5}'; }
get_disk_free(){ df -h / | awk 'NR==2{print $4}'; }
