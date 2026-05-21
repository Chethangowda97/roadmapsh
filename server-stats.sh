#!/bin/bash
echo "tub supi balu"
# server-stats.sh
# Basic Linux Server Performance Statistics

echo "========================================"
echo "      SERVER PERFORMANCE STATS"
echo "========================================"
echo ""

# HOSTNAME
echo "Hostname: $(hostname)"

# OS VERSION
echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo ""

# UPTIME
echo "System Uptime:"
uptime -p
echo ""

# LOAD AVERAGE
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo ""

# CPU USAGE
echo "========================================"
echo "CPU USAGE"
echo "========================================"

cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
cpu_usage=$((100 - cpu_idle))

echo "Total CPU Usage: ${cpu_usage}%"
echo ""

# MEMORY USAGE
echo "========================================"
echo "MEMORY USAGE"
echo "========================================"

mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')

mem_usage_percent=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')

echo "Total Memory : ${mem_total} MB"
echo "Used Memory  : ${mem_used} MB"
echo "Free Memory  : ${mem_free} MB"
echo "Memory Usage : ${mem_usage_percent}%"
echo ""

# DISK USAGE
echo "========================================"
echo "DISK USAGE"
echo "========================================"

df -h --total | grep 'total' | awk '
{
    print "Total Disk Space : " $2
    print "Used Disk Space  : " $3
    print "Free Disk Space  : " $4
    print "Disk Usage       : " $5
}'
echo ""

# TOP 5 CPU CONSUMING PROCESSES
echo "========================================"
echo "TOP 5 PROCESSES BY CPU USAGE"
echo "========================================"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo ""

# TOP 5 MEMORY CONSUMING PROCESSES
echo "========================================"
echo "TOP 5 PROCESSES BY MEMORY USAGE"
echo "========================================"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo ""

# LOGGED IN USERS
echo "========================================"
echo "LOGGED IN USERS"
echo "========================================"

who
echo ""

# FAILED LOGIN ATTEMPTS
echo "========================================"
echo "FAILED LOGIN ATTEMPTS"
echo "========================================"

lastb | head
echo ""

echo "========================================"
echo "        END OF SERVER REPORT"
echo "========================================"
