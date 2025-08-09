#!/bin/bash

DEFAULT_RESOURCE_ID="d27ee539-3d00-4bbe-9b3b-2cbaf5aff071"

# change the default resource id or call the script with the resource id
STACK_ID="${1:-$DEFAULT_RESOURCE_ID}"
STACK_NAME="${2:-'stack0'}"

mkdir -p $STACK_NAME
# mkdir -p ./stack0

while true; do

    echo "Timestamp: $(date)"
    # logging cpu usage for the both
    echo "Timestamp: $(date)" >./$STACK_NAME/servers_cpu_util_p.log
    echo "Timestamp: $(date)" >./$STACK_NAME/servers_cpu_util_n.log
    echo "Timestamp: $(date)" >./$STACK_NAME/servers_memory.log

    openstack metric aggregates --granularity 60 --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 60000000000.0) 100)" \
        "server_group=$STACK_ID" >>./$STACK_NAME/servers_cpu_util_p.log
    openstack metric aggregates --granularity 60 -f csv --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 60000000000.0) 100)" \
        "server_group=$STACK_ID" >./$STACK_NAME/servers_cpu_util_p.csv

    # openstack metric aggregates --resource-type instance \
    #     "(aggregate rate:mean (metric cpu mean))" \
    #     "server_group=$STACK_ID" >>./$STACK_NAME/servers_cpu_util_n.log
    # openstack metric aggregates -f csv --resource-type instance \
    #     "(aggregate rate:mean (metric cpu mean))" \
    #     "server_group=$STACK_ID" >./$STACK_NAME/servers_cpu_util_n.csv

    # openstack metric aggregates --resource-type instance \
    #     "(aggregate mean (metric memory.usage mean))" \
    #     "server_group=$STACK_ID" >>./$STACK_NAME/servers_memory.log
    openstack metric aggregates -f csv --resource-type instance \
        "(aggregate mean (metric memory.usage mean))" \
        "server_group=$STACK_ID" >./$STACK_NAME/servers_memory.csv

    echo "Metrics logged. Sleeping for 5 minutes..."
    sleep 300 # Wait for 5 minutes (300 seconds)

done
