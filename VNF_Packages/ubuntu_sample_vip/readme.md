# VNFD package

!! not fully tested

!! remember to change image information (name (must) and hash (not sure if required)) in the Definitions/vnfd*df*...yaml file

or create image with the same name

## description

### flavor: simple

the same as scale package

one scalable VDU with 2 CP per instance, the ips are not fixed

CP0 connect to internal virtual link

CP1 connect to external network

### flavor: ha

one scalable VDU (1-3 intances)

one CP per instance, connect to internal VL, the ips are not fixed

one router connect internalVL to external network

one CP (port) in internalVL, act as Virtual Ip

2-4 floating IP, associated to each CP (floating ip is used so extnet must be public, you can rewrite the HOT and vnfd of ha flavor to make it use 2 CPs per instace like simple simple flavor)

this flavor setup a virtual ip for 1 scalable VDU (1-3 instances) of heatAutoScalingGroup

But there are more thing to do, you need to

- config VM image to make it work with VIP (helpful article: https://medium.com/@nuriel_25979/virtual-ip-with-openstack-neutron-dd9378a48bdf)
- I didnt fully check if the ha flavor works correctly, but the simple flavor should works

### note

I actually want a load balancer, so I need to somehow make the scalable VDU use some fixed ip addresses
see scale_lb package
