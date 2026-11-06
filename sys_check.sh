#!/bin/bash

# Create a logs directory if it doesn't exist already
LOG_DIR="$HOME/Desktop/scripts/logs"
mkdir -p "$LOG_DIR"

# Generate a timestamped log filename
LOG_FILE="$LOG_DIR/sys_check_$(date +%Y-%m-%d_%H-%M-%S).log"

{
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

    echo ""
    # Check CPU load average
    CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | xargs)
    echo "CPU Load Average: $CPU_LOAD"
    echo "Host machine: $(hostname)"

    echo "==========================="
} | tee -a "$LOG_FILE"

echo ""
echo "📝 Report saved successfully to: $LOG_FILE"
