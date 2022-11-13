#! /bin/bash
#####	VPP Installation Steps on Linux Ubuntu-20.04
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo timedatectl set-timezone Asia/Kolkata
sudo apt update -y
sudo apt install inetutils-ping inetutils-traceroute vim wget tcpdump net-tools iperf3 ifupdown lshw -y

cat << EOF | tee /etc/hostname
PP-VPP02
EOF
cat << EOF | tee  /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

allow-hotplug enp0s3
iface enp0s3 inet static
             address 192.168.56.152/24
allow-hotplug enp0s8
iface enp0s8 inet dhcp
EOF

cat << EOF | tee /etc/network/interfaces.d/dpdk-interfaces.conf
#### DPDK interfaces for VPP
allow-hotplug enp0s9
allow-hotplug enp0s10
EOF
rm -rf /etc/netplan/*.yaml
systemctl restart networking
sed -i 's/127.0.1.1\tlocalhost/192.168.56.152\tPP-VPP02/g' /etc/hosts

mkdir -p /var/log/vpp/
cat << EOF | tee /var/log/vpp/vpp.log
### VPP Logs
EOF

cat <<EOF | sudo tee /etc/apt/sources.list.d/99fd.io.list
deb [trusted=yes] https://packagecloud.io/fdio/release/ubuntu focal main
EOF
curl -L https://packagecloud.io/fdio/release/gpgkey | sudo apt-key add -

sudo apt-get update -y
sudo apt-get install vpp vpp-plugin-core vpp-plugin-dpdk dpdk -y
systemctl start dpdk
