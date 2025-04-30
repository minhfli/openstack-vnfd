#!/bin/bash

# === Configuration ===
INSTANCE_IP="http://172.24.4.127" # IP or DNS of the instance
CHECK_INTERVAL=1                  # Time between checks in seconds
scale_level=-1
LOG="reboot_log.txt"
retry=60

for ((i = 0; i < retry; i++)); do
    STACK_STATUS=$(openstack stack show stack0 -f value -c stack_status)
    if [[ "$STACK_STATUS" == "UPDATE_IN_PROGRESS" ]]; then
        echo "Stack is in UPDATE_IN_PROGRESS state. Waiting for 60s..."
        sleep 60
    else
        echo "$i th iteration"
        echo "$i th iteration" >>"$LOG"
        scale_level=$((scale_level + 1))
        if [[ $scale_level -gt 2 ]]; then
            scale_level=0
        fi
        # === Step 1: Reboot the instance ===
        openstack stack update --parameter "VDU1-scale-level=$scale_level" --existing stack0
        UPDATE_TIME=$(date +%s)
        echo "Update started at: $UPDATE_TIME"
        echo "Update started at: $UPDATE_TIME" >>"$LOG"

        # === Step 2: Monitor the instance ===
        echo "Monitoring instance at $INSTANCE_IP... - scale level = $scale_level" >>"$LOG"

        # Wait until instance goes DOWN
        echo "Waiting for instance to go DOWN..."
        while curl -s --connect-timeout 1 "$INSTANCE_IP" >/dev/null; do
            sleep $CHECK_INTERVAL
        done
        DOWN_TIME=$(date +%s)
        echo "Instance went DOWN at: $DOWN_TIME"
        echo "Instance went DOWN at: $DOWN_TIME" >>"$LOG"

        # Wait until instance comes UP
        echo "Waiting for instance to come UP..."
        while ! curl -s --connect-timeout 1 "$INSTANCE_IP" >/dev/null; do
            sleep $CHECK_INTERVAL
        done
        UP_TIME=$(date +%s)
        echo "Instance came UP at: $UP_TIME"
        echo "Instance came UP at: $UP_TIME" >>"$LOG"

        # === Step 3: Calculate reboot time ===
        REBOOT_TIME=$((UP_TIME - DOWN_TIME))
        echo "Reboot time: $REBOOT_TIME seconds"
        echo "Reboot time: $REBOOT_TIME seconds" >>"$LOG"

        # === Step 4: Calculate total time ===
        TOTAL_TIME=$((UP_TIME - UPDATE_TIME))
        echo "Total time: $TOTAL_TIME seconds"
        echo "Total time: $TOTAL_TIME seconds" >>"$LOG"

        echo "Waiting for 60 seconds before next iteration..."
        sleep 60
    fi
done
