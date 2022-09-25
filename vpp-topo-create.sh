### Adding the VPP Topology

cat << EOF | tee ~/topo_create.sh
ip netns add host01
ip netns add host02
ip link add name host01-eth0 netns host01 type veth peer name sw01-p01
ip link add name host02-eth0 netns host02 type veth peer name sw01-p02
ip netns exec host01 ip link set mtu 9000 host01-eth0
ip netns exec host02 ip link set mtu 9000 host02-eth0
ip link set mtu 9000 sw01-p01
ip link set mtu 9000 sw01-p02
ip netns exec host01 ip link set host01-eth0 up
ip netns exec host02 ip link set host02-eth0 up
ip link set sw01-p01 up
ip link set sw01-p02 up
ip netns exec host01 ip addr add 10.10.10.1/30 dev host01-eth0
ip netns exec host02 ip addr add 10.10.10.2/30 dev host02-eth0
vppctl create bridge-domain 100 sw01
vppctl create host-interface name sw01-p01
vppctl create host-interface name sw01-p02
vppctl set interface state host-sw01-p01 up
vppctl set interface state host-sw01-p02 up
vppctl set interface l2 bridge host-sw01-p01 100
vppctl set interface l2 bridge host-sw01-p02 100
EOF
chmod +x ~/topo_create.sh
