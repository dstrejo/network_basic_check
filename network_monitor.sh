#!/bin/bash

# Function to get the status of network interfaces
check_interfaces() {
    echo "Checking network interfaces..."
    ip -br a
    echo "Network interfaces checked."
}

# Function to ping remote hosts
ping_hosts() {
	hosts=("8.8.8.8" "1.1.1.1")
    echo "Pinging remote hosts..."
    for host in "${hosts[@]}"; do
        ping -c 4 $host > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Host $host is reachable."
        else
            echo "Host $host is not reachable."
        fi
    done
    echo "Remote hosts pinged."
}

# Function to check network ports
check_ports() {
    echo "Checking network ports..."
    host="localhost"
    ports=(22 80 443)
    for port in "${ports[@]}"; do
        nc -zv $host $port > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Port $port on $host is open."
        else
            echo "Port $port on $host is closed."
        fi
    done
    echo "Network ports checked."
}

# Function to log the results
log_results() {
    logfile="network_monitor.log"
    echo "Logging results to $logfile..."
    {
        echo "=== Network Monitoring Results ==="
        echo "Timestamp: $(date)"
        echo ""
        check_interfaces
        echo ""
        ping_hosts
        echo ""
        check_ports
        echo ""
        echo "=================================="
        echo ""
    } 2>&1 | tee -a $logfile
    echo "Results logged."
}

# Main script execution
log_results
