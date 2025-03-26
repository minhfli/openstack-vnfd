#!/bin/bash

# OpenStack Resource ID
RESOURCE_ID="d27ee539-3d00-4bbe-9b3b-2cbaf5aff071"

# Log files
MEMORY_LOG="memory.txt"
CPU_LOG="cpu.txt"
CPU_util_LOG="cpu_util.txt"

while true; do
    echo "=== $(date) ===" > $MEMORY_LOG
    openstack metric measures show --resource-id $RESOURCE_ID memory.usage >> $MEMORY_LOG

    echo "=== $(date) ===" > $CPU_LOG
    openstack metric measures show --resource-id $RESOURCE_ID cpu >> $CPU_LOG

    echo "=== $(date) ===" > $CPU_util_LOG
    gnocchi aggregates --resource-type instance                      \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)"               \
        "id=$RESOURCE_ID" >> $CPU_util_LOG

    echo "Metrics logged. Sleeping for 5 minutes..."
    sleep 300  # Wait for 5 minutes (300 seconds)
done
