# simple auto scaling vnf-package

It is similar to the scale package, but lighter, this is only for testing autoscaling with suricata

I intended to use the auto-healing part from the HOT/autoscale template, but since tacker has auto-healing, I don't need it, and it make this package lighter

To monitor cpu and memory usage, use metrics/monitor.sh

## Additional param (in param.json)

must be in that format, otherwise it will not work

## TODO

- add load balancing
