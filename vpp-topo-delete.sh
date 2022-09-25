### Deleting the VPP Topology
cat << EOF | tee ~/topo_del.sh
vppctl set interface l3 host-sw01-p01
vppctl set interface l3 host-sw01-p02
vppctl create bridge-domain 100 del
vppctl delete host-interface name sw01-p01
vppctl delete host-interface name sw01-p02
ip link delete sw01-p01
ip link delete sw01-p02
ip netns delete host01
ip netns delete host02
EOF
chmod +x ~/topo_del.sh
