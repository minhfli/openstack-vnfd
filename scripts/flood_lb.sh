IP=172.24.4.20

port=80

# Test the load balancer

echo "" >response.txt
count=0

logging=False

if [ "$logging" = False ]; then
    while true; do
        time curl http://$IP:$port >/dev/null
    done
else
    # Create a directory to store the logs
    mkdir -p ./logs
    # Create a log file with a timestamp
    log_file="./logs/response.log"
    echo "" >$log_file
    while true; do
        count=$((count + 1))
        response=$(curl http://$IP:$port)
        echo "$response" >>$log_file
    done
fi
