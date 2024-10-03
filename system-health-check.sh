#!/bin/bash

# Disk usage check
disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $disk_usage -gt 80 ]; then
    echo "Disk usage is critical: ${disk_usage}%"
fi

# Memory check
total_memory=$(free | grep Mem: | awk '{print $2}')
free_memory=$(free | grep Mem: | awk '{print $4}')
memory_usage=$((100 - ($free_memory * 100 / $total_memory)))
if [ $memory_usage -gt 90 ]; then
    echo "Memory usage is critical: ${memory_usage}% used"
fi

# CPU load check
cpu_load=$(uptime | awk -F'[a-z]:' '{ print $2}' | cut -d, -f3)
if (( $(echo "$cpu_load > 1" | bc -l) )); then
    echo "CPU load is high: current 15-min load average is $cpu_load"
fi
