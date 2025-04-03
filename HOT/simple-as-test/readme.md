# description

an autoscaling group with autohealing instances

# helpful commands

```bash
openstack stack create --enable-rollback  -t base.yaml -e env.yaml stack1
# enable-rollback: if the stack creation fails, it will safely rollback

```

# target

2 haproxy server MASTER and BACKUP, load-balancing apache2 servers  

VIP for ha servers, setup high availability for ha servers

1 autoscaling group with autohealing apache2 servers

# prepare

devstack with
- heat
- aodh
- ceilometer (with gnocchi, and enable event alarm)
- mistral (with mistral-extra)
- zaqar 

flavors: read env file

image: 
- jammy-base: apache2 keepalived haproxy stress
- or anything similar




