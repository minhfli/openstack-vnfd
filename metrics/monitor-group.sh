#!/bin/bash

SERVER1=8fc212e7-f359-45bd-b0ba-4515a13c35bd
SERVER2=60984c4d-ad79-4bd6-9c1d-15b25ef40ae7

STACK_ID=eca1f527-4634-46c8-b526-73583225f38b

mkdir -p ./stack0

while true; do

    echo "Timestamp: $(date)"

    # logging ram usage for each server
    openstack metric measures show --utc --resource-id $SERVER1 memory.usage >./stack0/server1_memory.log
    openstack metric measures show --utc --resource-id $SERVER2 memory.usage >./stack0/server2_memory.log

    # openstack metric measures show --utc --resource-id "$SERVER1" cpu >./stack0/server1_cpu.log
    # openstack metric measures show --utc --resource-id "$SERVER2" cpu >./stack0/server2_cpu.log

    # logging cpu usage for each server
    openstack metric aggregates --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "id=$SERVER1" >./stack0/server1_cpu_util_p.log
    openstack metric aggregates --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "id=$SERVER2" >./stack0/server2_cpu_util_p.log

    # logging cpu usage for the both
    openstack metric aggregates --resource-type instance \
        "(* ( / (aggregate rate:mean (metric cpu mean)) 300000000000.0) 100)" \
        "server_group=$STACK_ID" >./stack0/servers_cpu_util_p.log

    openstack metric aggregates --resource-type instance \
        "(aggregate mean (metric cpu mean))" \
        "server_group=$STACK_ID" >./stack0/servers_memory.log

    echo "Metrics logged. Sleeping for 5 minutes..."
    sleep 300 # Wait for 5 minutes (300 seconds)

done
