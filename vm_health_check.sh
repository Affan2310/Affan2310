#!/bin/bash

##############################################################################
# VM Health Check Script
# Description: Analyzes the health of a virtual machine based on CPU,
#              memory, and disk space utilization.
# Usage: ./vm_health_check.sh [explain]
# Author: System Administrator
# Date: 2026
##############################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Threshold for unhealthy status (in percentage)
THRESHOLD=70

# Explain flag
EXPLAIN=false

# Check if 'explain' argument is provided
if [ "$1" == "explain" ]; then
    EXPLAIN=true
fi

##############################################################################
# Function: Get CPU utilization
# Returns: CPU utilization percentage (0-100)
##############################################################################
get_cpu_utilization() {
    # Get the average CPU utilization over 1 second
    # Using top command with batch mode
    local cpu_util=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    # Fallback method if top fails
    if [ -z "$cpu_util" ]; then
        cpu_util=$(ps aux | awk 'BEGIN {sum=0} {sum+=$3} END {print sum}')
    fi
    
    # Round to nearest integer
    printf "%.0f" "$cpu_util"
}

##############################################################################
# Function: Get memory utilization
# Returns: Memory utilization percentage (0-100)
##############################################################################
get_memory_utilization() {
    # Get memory info from /proc/meminfo
    local mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    local mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    
    # Calculate utilization percentage
    local mem_used=$((mem_total - mem_available))
    local mem_percent=$((mem_used * 100 / mem_total))
    
    echo "$mem_percent"
}

##############################################################################
# Function: Get disk space utilization
# Returns: Disk space utilization percentage (0-100)
##############################################################################
get_disk_utilization() {
    # Get disk utilization for root filesystem
    local disk_util=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
    
    echo "$disk_util"
}

##############################################################################
# Function: Determine health status
# Arguments: $1=CPU%, $2=Memory%, $3=Disk%
# Returns: "Healthy" or "Unhealthy"
##############################################################################
determine_health_status() {
    local cpu=$1
    local memory=$2
    local disk=$3
    
    if [ "$cpu" -gt "$THRESHOLD" ] || [ "$memory" -gt "$THRESHOLD" ] || [ "$disk" -gt "$THRESHOLD" ]; then
        echo "Unhealthy"
    else
        echo "Healthy"
    fi
}

##############################################################################
# Function: Print health status with colors
##############################################################################
print_health_status() {
    local status=$1
    
    if [ "$status" == "Healthy" ]; then
        echo -e "${GREEN}✓ VM Health Status: $status${NC}"
    else
        echo -e "${RED}✗ VM Health Status: $status${NC}"
    fi
}

##############################################################################
# Function: Print detailed explanation
##############################################################################
print_explanation() {
    local cpu=$1
    local memory=$2
    local disk=$3
    local status=$4
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "VM Health Check Details (Threshold: ${THRESHOLD}%)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    # CPU Status
    if [ "$cpu" -gt "$THRESHOLD" ]; then
        echo -e "CPU Utilization:    ${RED}$cpu%${NC} (CRITICAL - Above threshold)"
    else
        echo -e "CPU Utilization:    ${GREEN}$cpu%${NC} (NORMAL)"
    fi
    
    # Memory Status
    if [ "$memory" -gt "$THRESHOLD" ]; then
        echo -e "Memory Utilization: ${RED}$memory%${NC} (CRITICAL - Above threshold)"
    else
        echo -e "Memory Utilization: ${GREEN}$memory%${NC} (NORMAL)"
    fi
    
    # Disk Status
    if [ "$disk" -gt "$THRESHOLD" ]; then
        echo -e "Disk Utilization:   ${RED}$disk%${NC} (CRITICAL - Above threshold)"
    else
        echo -e "Disk Utilization:   ${GREEN}$disk%${NC} (NORMAL)"
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Summary:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [ "$status" == "Healthy" ]; then
        echo -e "${GREEN}✓ The VM is HEALTHY.${NC}"
        echo "All resource utilization metrics are within acceptable limits."
        echo "No immediate action is required."
    else
        echo -e "${RED}✗ The VM is UNHEALTHY.${NC}"
        echo "One or more resource utilization metrics exceeded the threshold."
        echo ""
        echo "Recommended Actions:"
        
        if [ "$cpu" -gt "$THRESHOLD" ]; then
            echo "  • CPU: Investigate running processes using 'top' or 'ps aux'"
            echo "         Consider terminating unnecessary processes or scaling up"
        fi
        
        if [ "$memory" -gt "$THRESHOLD" ]; then
            echo "  • Memory: Review memory-consuming applications using 'free -h'"
            echo "           Consider increasing VM RAM or optimizing memory usage"
        fi
        
        if [ "$disk" -gt "$THRESHOLD" ]; then
            echo "  • Disk: Clean up unnecessary files using 'du -sh /*'"
            echo "          Consider expanding disk space or archiving old files"
        fi
    fi
    
    echo ""
}

##############################################################################
# Main Script Execution
##############################################################################

echo ""
echo "╔════════════════════════════════════════════════════════════════════════╗"
echo "║                   VM HEALTH CHECK SCRIPT                              ║"
echo "║                         Ubuntu System                                 ║"
echo "╚════════════════════════════════════════════════════════════════════════╝"
echo ""

# Get current system metrics
CPU=$(get_cpu_utilization)
MEMORY=$(get_memory_utilization)
DISK=$(get_disk_utilization)

# Determine health status
HEALTH_STATUS=$(determine_health_status "$CPU" "$MEMORY" "$DISK")

# Print basic status
print_health_status "$HEALTH_STATUS"

# Print detailed explanation if requested
if [ "$EXPLAIN" = true ]; then
    print_explanation "$CPU" "$MEMORY" "$DISK" "$HEALTH_STATUS"
fi

echo ""

# Exit with appropriate code
if [ "$HEALTH_STATUS" == "Healthy" ]; then
    exit 0
else
    exit 1
fi
