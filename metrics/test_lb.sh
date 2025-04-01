
lb_IP=172.24.4.118

lb_port=80

# Test the load balancer

echo "" > response.txt

for i in {1..100}
do
  # Send a request to the load balancer 
    response=$(curl http://$lb_IP:$lb_port)

    echo $response >> response.txt
done