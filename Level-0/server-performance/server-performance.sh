#!/bin/bash

echo "================= SERVER PERFORMANCE STATS ================="

# Get total CPU usage
echo -e "\n>>> Total CPU Usage:"
# mpstat is part of sysstat, fallback to top if mpstat not available
if command -v mpstat >/dev/null 2>&1; then
    mpstat 1 1 | awk '/Average:/ && $12 ~ /[0-9.]+/ { printf("CPU Usage: %.2f%%\n", 100 - $12) }'
else
    top -bn1 | grep "Cpu(s)" | awk '{usage=100 - $8} END {printf("CPU Usage: %.2f%%\n", usage)}'
fi

# Get total memory usage
echo -e "\n>>> Memory Usage:"
free -m | awk 'NR==2 {
    used=$3; free=$4; total=$2;
    printf("Used: %d MB | Free: %d MB | Total: %d MB | Usage: %.2f%%\n", used, free, total, (used/total)*100)
}'

# Get total disk usage (for /)
echo -e "\n>>> Disk Usage (/):"
df -h / | awk 'NR==2 {
    printf("Used: %s | Free: %s | Total: %s | Usage: %s\n", $3, $4, $2, $5)
}'

# Top 5 processes by CPU usage
echo -e "\n>>> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 | awk 'NR==1{printf "%-8s %-20s %-10s %-10s\n", "PID", "COMMAND", "%CPU", "%MEM"} NR>1{printf "%-8s %-20s %-10s %-10s\n", $1, $2, $3, $4}'

# Top 5 processes by Memory usage
echo -e "\n>>> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6 | awk 'NR==1{printf "%-8s %-20s %-10s %-10s\n", "PID", "COMMAND", "%CPU", "%MEM"} NR>1{printf "%-8s %-20s %-10s %-10s\n", $1, $2, $3, $4}'

echo -e "\n============================================================"
