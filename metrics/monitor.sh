#!/bin/bash

# simple script to monitor the CPU and memory usage of an OpenStack instance

# Default OpenStack Resource ID (Can be overridden by command-line argument)
DEFAULT_RESOURCE_ID="d27ee539-3d00-4bbe-9b3b-2cbaf5aff071"

# change the default resource id or call the script with the resource id
RESOURCE_ID="${1:-$DEFAULT_RESOURCE_ID}"

# Log files
MEMORY_LOG="memory.log"
CPU_LOG="cpu.log"
CPU_util_p_LOG="cpu_util_percentage.log"
CPU_util_n_LOG="cpu_util_nanosecond.log"

# mkdir if not exist

SERVER_NAME=$(openstack server show $RESOURCE_ID -f value -c name)
if [ -z "$SERVER_NAME" ]; then
    echo "Error: Unable to retrieve server name for resource ID $RESOURCE_ID."
    exit 1
fi
mkdir -p $SERVER_NAME
CURRENT_DATE="$(date +%Y-%m-%d)"

mkdir -p ./$SERVER_NAME/$CURRENT_DATE

while true; do
    echo "=== $(date) ===" >./$SERVER_NAME/$CURRENT_DATE/$MEMORY_LOG
    openstack metric measures show --utc --resource-id "$RESOURCE_ID" memory.usage >>./$SERVER_NAME/$CURRENT_DATE/$MEMORY_LOG
    openstack metric measures show -f csv --utc --resource-id "$RESOURCE_ID" memory.usage >./$SERVER_NAME/$CURRENT_DATE/$MEMORY_LOG.csv

    echo "=== $(date) ===" >./$SERVER_NAME/$CURRENT_DATE/$CPU_LOG
    openstack metric measures show --utc --resource-id "$RESOURCE_ID" cpu >>./$SERVER_NAME/$CURRENT_DATE/$CPU_LOG
    openstack metric measures show -f csv --utc --resource-id "$RESOURCE_ID" cpu >./$SERVER_NAME/$CURRENT_DATE/$CPU_LOG.csv

    echo "=== $(date) ===" >./$SERVER_NAME/$CURRENT_DATE/$CPU_util_p_LOG
    openstack metric aggregates --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "id=$RESOURCE_ID" >>./$SERVER_NAME/$CURRENT_DATE/$CPU_util_p_LOG
    openstack metric aggregates -f csv --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "id=$RESOURCE_ID" >./$SERVER_NAME/$CURRENT_DATE/$CPU_util_p_LOG.csv

    echo "=== $(date) ===" >./$SERVER_NAME/$CURRENT_DATE/$CPU_util_n_LOG
    openstack metric aggregates --resource-type instance \
        "(aggregate rate:mean (metric cpu mean))" \
        "id=$RESOURCE_ID" >>./$SERVER_NAME/$CURRENT_DATE/$CPU_util_n_LOG
    openstack metric aggregates -f csv --resource-type instance \
        "(aggregate rate:mean (metric cpu mean))" \
        "id=$RESOURCE_ID" >./$SERVER_NAME/$CURRENT_DATE/$CPU_util_n_LOG.csv

    echo "Metrics logged. Sleeping for 5 minutes..."
    sleep 300 # Wait for 5 minutes (300 seconds)
done
