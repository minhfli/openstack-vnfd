#!/bin/bash
IGNORE_ID="4acc104a-12b8-4ea2-a692-e444f17f798c"

openstack server list -c ID -f csv | tail -n +2 | tr -d '"' | while read id; do
    if [[ "$id" == "$IGNORE_ID" ]]; then
        continue
    fi
    # echo "=== Logs for $id ==="
    openstack console log show "$id" --lines 5 | grep -io "Up [0-9.]\+ seconds"
done
