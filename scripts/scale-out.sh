#!/usr/bin/env bash

export OS_AUTH_URL=http://0.0.0.0/identity
# change this acording to your openrc file (you can download it from horizon)
export OS_PROJECT_ID=4365aa744a284c5a9c5c014e9c4b5e5f
export OS_PROJECT_NAME="demo"
export OS_USER_DOMAIN_NAME="Default"

if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi
export OS_PROJECT_DOMAIN_ID="default"
if [ -z "$OS_PROJECT_DOMAIN_ID" ]; then unset OS_PROJECT_DOMAIN_ID; fi
unset OS_TENANT_ID
unset OS_TENANT_NAME

# Login as user
export OS_USERNAME="admin"
export OS_PASSWORD="devstack"

export OS_REGION_NAME="RegionOne"
# Don't leave a blank variable, unset it if it was empty
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3

export OS_TACKER_API_VERSION=2

vnf_instance_id=$1
if [ -z "$vnf_instance_id" ]; then
    echo "Usage: $0 <vnf_instance_id>"
    exit 1
fi
# scaling part 
openstack vnflcm --os-tacker-api-version 2 scale --type SCALE_OUT --aspect-id VDU1_scale 0a13ee34-ad60-44fa-9feb-3f83b0d6c5a5
