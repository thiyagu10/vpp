#! /bin/bash
#####	VPP Installation Steps on Linux Ubuntu-20.04
sed -i '/PermitRootLogin/s/prohibit-password/yes/' /etc/ssh/sshd_config
sed -i '/PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo timedatectl set-timezone Asia/Kolkata
sudo apt update -y
sudo apt install inetutils-ping inetutils-traceroute vim wget tcpdump net-tools iperf3 ifupdown lshw -y

cat << EOF | tee /etc/hostname
PP-VPP01
EOF

sed -i 's/127.0.1.1/192.168.56.151\tPP-VPP01/g' /etc/hosts

mkdir -p /var/log/vpp/
cat << EOF | tee /var/log/vpp/vpp.log
### VPP Logs
EOF

cat << EOF | tee /etc/network/interfaces.d/dpdk-interfaces.conf
#### DPDK interfaces for VPP
allow-hotplug enp0s9
allow-hotplug enp0s10
EOF
systemctl restart networking

cat <<EOF | sudo tee /etc/apt/sources.list.d/99fd.io.list
deb [trusted=yes] https://packagecloud.io/fdio/release/ubuntu focal main
EOF
curl -L https://packagecloud.io/fdio/release/gpgkey | sudo apt-key add -

sudo apt-get update -y
sudo apt-get install vpp vpp-plugin-core vpp-plugin-dpdk dpdk -y

systemctl start dpdk
