# VNFD package

!! unfinished

!! remember to change image information (name (must) and hash (not sure if required)) in the Definitions/vnfd*df*...yaml file

or create image with the same name

## description

### flavor: simple

the same as scale package

## 2 approach:

### flavor: dynamic (currently working on)

using heat template output to get fixed ips of the spawned instances

### flavor: inded

using %index% on heat resource group for name and ip address

### flavor: fixed

Trying to change the UserData script to make the scalable VDU use some fixed IPs
