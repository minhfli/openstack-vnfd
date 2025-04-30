#!/bin/bash

# === Configuration ===
INSTANCE_IP="http://10.0.5.5" # IP or DNS of the instance
CHECK_INTERVAL=1              # Time between checks in seconds

scale_level=1
LOG="reboot_log.txt"

# === Step 1: Reboot the instance ===
openstack stack update -p "VDU1-scale-level=$scale_level" --existing stack0

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
