# VNFD package

!! unfinished

!! remember to change image information (name (must) and hash (not sure if required)) in the Definitions/vnfd*df*...yaml file

or create image with the same name

## description

### flavor: simple

the same as scale package

## 2 approach:

### flavor: index (currently working on)

1 scalable VDU as 1-3 instance, with name as the last part of their ips
each connect to 2 network, internal and external  

return outputs of list of ips for future development

### flavor: fixed

Trying to change the UserData script to make the scalable VDU use some fixed IPs
