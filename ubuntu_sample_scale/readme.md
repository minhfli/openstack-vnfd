# VNFD package

## description

one scalable VDU with 2 CP
CP0 is connected to internalVL
CP1 is connected to external network: net0 (see param.json)

## some note
in param.json file, fixed ip address is not used, because 2 VM (basically VDU scale into 2 or more instances) can not have the same ip
see more in BaseHOT VDU1.yaml, I use subnet instead of fixedIP
if your VDU cannot scale or only scale from 0 to 1, you can use fixedIP
otherwise, you have to use a virtual IP

in df_simple.param file, I used ubuntu 24 server image
If you just want to test, change it to cirros, or you can change it into anything (you has to have uploaded os image to openstack)

## scaling

### list stack, find your stack with status CREATE_COMPLETE
openstack stack list --nested -c 'ID' -c 'Stack Name' -c 'Stack Status' -c 'Parent' --os-tacker-api-version 2


### scale
WORKER_INSTANCE: see   vnfd - topology_template - policies - scaling_aspects
VNF_INSTANCE_ID: see in horizon or the stack above

openstack vnflcm --os-tacker-api-version 2 scale --type SCALE_OUT --aspect-id WORKER_INSTANCE VNF_INSTANCE_ID
openstack vnflcm --os-tacker-api-version 2 scale --type SCALE_OUT --aspect-id VDU1_scale 0a13ee34-ad60-44fa-9feb-3f83b0d6c5a5

### check again
openstack stack list --nested -c 'ID' -c 'Stack Name' -c 'Stack Status' -c 'Parent' --os-tacker-api-version 2
