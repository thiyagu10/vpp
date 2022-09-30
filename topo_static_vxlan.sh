
### VXLAN-GPE tunnel between vpp01 to vpp02
loopback create mac 1a:2b:3c:4d:5e:11
create bridge-domain 1111 learn 1 forward 1 uu-flood 1 flood 1 arp-term 0
create vxlan-gpe tunnel local 100.64.10.1 remote 100.64.10.2 vni 1111
set interface l2 bridge vxlan_gpe_tunnel0 1111 1
set interface l2 bridge loop0 1111 bvi 
set interface ip table loop0 0

### VXLAN-GPE tunnel between vpp02 to vpp01
loopback create mac 1a:2b:3c:4d:5e:22
create bridge-domain 1111 learn 1 forward 1 uu-flood 1 flood 1 arp-term 0
create vxlan-gpe tunnel local 100.64.10.2 remote 100.64.10.1 vni 1111
set interface l2 bridge vxlan_gpe_tunnel0 1111 1
set interface l2 bridge loop0 1111 bvi
set interface ip table loop0 0
