# description

an autoscaling group with autohealing instances

One autoscaling group with 2 instances, and a load balancer

you can also vertical scale them, by disable autoscaling, changing the flavor and stack update

# helpful commands

```bash
openstack stack create --enable-rollback  -t base.yaml -e env.yaml stack1
# enable-rollback: if the stack creation fails, it will safely rollback

# dry-run: see what resouces woulde be changed or updated, not nessarily accurate
# resource placed under replaced: not will be replaced, but can be replaced if other resources changed, make this resource need to be replaced
# resource placed under updated: (not will) can be updated
# resource placed under unchanged: will not be changed

openstack stack update -e env1.yaml --existing --dry-run stack0 \
| grep -e added -e deleted -e replaced -e unchanged -e updated -e resource_type -e "| ]" -e + \
> ./temp/test_update

openstack stack update -e env1.yaml --existing stack0 > ./temp/test_update
```

# prepare

devstack with

- heat
- aodh
- ceilometer (with gnocchi, and enable event alarm)

flavors: read env file

image:

- jammy-base: apache2 keepalived haproxy stress
- or anything similar
