# VNFD package

## description

one scalable VDU with 2 CP
CP0 is connected to internalVL
CP1 is connected to external network: net0 (see param.json)

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
