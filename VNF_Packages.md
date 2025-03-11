# Some note about tacker's VNF Package format

## Package format

for VNF LCM v2, there must be BaseHot folder,

It seem like VNF LCM v2 use Heat with BaseHot/ to actually create virtual resources, and vnfds are just descriptions, do nothing, then get processed by UserData to become input parameter for Heat 

you dont need UserData but if UserData is not in package, the defaultUserData class will be used (the same class as in my packages), you can also customize it

descriptor id (defined in top.yaml) doesnt have any specific format ? I tried some weird value and it still works

the BaseHOT yaml file's name doesnt matter, as long as there is one file yaml in BaseHOT/flavor/ folder, nested folder is optional

## HOT

It seems like %index% only work with OS::HEAT::ResourceGroup, not AutoScalingGroup

