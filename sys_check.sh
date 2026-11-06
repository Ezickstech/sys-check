#!/bin/bash

echo "=== System Health Check ==="
echo "Date: $(date)"
echo "Current user: $USER"
echo ""

# Check disk usage on root partition
USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo "Root Partition Disk Usage: ${USAGE}%"

if [ "$USAGE" -gt 80 ]; then
    echo "⚠️ WARNING: Disk space is running low!"
else
    echo "✅ Status: Disk space is healthy."
fi

echo ""
# Check memory usage
FREE_MEM=$(free -m | grep Mem | awk '{print $3}')
TOTAL_MEM=$(free -m | grep Mem | awk '{print $2}')
echo "Memory Used: ${FREE_MEM}MB / ${TOTAL_MEM}MB"
# Check CPU load average
CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | xargs)
echo "CPU Load Average: $CPU_LOAD"

echo "==========================="
