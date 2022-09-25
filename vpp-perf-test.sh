### Testing the Topology

ip netns exec host01 ping 10.10.10.2 -c 4
ip netns exec host02 ping 10.10.10.1 -c 4

ip netns exec host01 iperf3 -s -p 5111 -B 10.10.10.1 &
ip netns exec host02 iperf3 -s -p 5222 -B 10.10.10.2 &
ip netns exec host01 iperf3 -c 10.10.10.2 -p 5222 -b 1G -M 2000 -t 10
ip netns exec host02 iperf3 -c 10.10.10.1 -p 5111 -b 1G -M 2000 -t 10
