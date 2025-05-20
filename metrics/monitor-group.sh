#!/bin/bash

DEFAULT_RESOURCE_ID="d27ee539-3d00-4bbe-9b3b-2cbaf5aff071"

# change the default resource id or call the script with the resource id
STACK_ID="${1:-$DEFAULT_RESOURCE_ID}"

mkdir -p ./stack0

while true; do

    echo "Timestamp: $(date)"

    # logging ram usage for each server
    # openstack metric measures show --utc --resource-id $SERVER1 memory.usage >./stack0/server1_memory.log
    # openstack metric measures show --utc --resource-id $SERVER2 memory.usage >./stack0/server2_memory.log

    # openstack metric measures show --utc --resource-id "$SERVER1" cpu >./stack0/server1_cpu.log
    # openstack metric measures show --utc --resource-id "$SERVER2" cpu >./stack0/server2_cpu.log

    # logging cpu usage for each server
    # openstack metric aggregates --resource-type instance \
    #     "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
    #     "id=$SERVER1" >./stack0/server1_cpu_util_p.log
    # openstack metric aggregates --resource-type instance \
    #     "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
    #     "id=$SERVER2" >./stack0/server2_cpu_util_p.log

    # logging cpu usage for the both
    echo "Timestamp: $(date)" >./stack0/servers_cpu_util_p.log
    echo "Timestamp: $(date)" >./stack0/servers_cpu_util_n.log
    echo "Timestamp: $(date)" >./stack0/servers_memory.log

    openstack metric aggregates --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "server_group=$STACK_ID" >>./stack0/servers_cpu_util_p.log

    openstack metric aggregates --resource-type instance \
        "(aggregate rate:mean (metric cpu mean))" \
        "server_group=$STACK_ID" >>./stack0/servers_cpu_util_n.log

    openstack metric aggregates --resource-type instance \
        "(aggregate mean (metric memory.usage mean))" \
        "server_group=$STACK_ID" >>./stack0/servers_memory.log

    echo "Metrics logged. Sleeping for 5 minutes..."
    sleep 300 # Wait for 5 minutes (300 seconds)

done
