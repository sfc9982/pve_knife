#!/bin/bash
ReplaceEnterpriseSource() {
    if [ -f "/etc/apt/sources.list.d/pve-enterprise.list"  ]; then
    mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak
    echo -e 'deb http://download.proxmox.com/debian/pve stretch pve-no-subscription\n' > /etc/apt/sources.list.d/pve-community.list
    fi
    echo "Source replacement already complete"
}

ReplaceDebianUpdateRepo() {
    cat > /etc/apt/sources.list <<EOF
deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb http://mirrors.aliyun.com/debian-security stretch/updates main
deb-src http://mirrors.aliyun.com/debian-security stretch/updates main
deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
EOF
}

AddReserveProxy() {
# Add For Proxmox Update
if [ `grep -c "89.31.125.19 download.proxmox.com" /etc/hosts` != '0' ]; then
	echo 'Done'
else
    echo "89.31.125.19 download.proxmox.com" >> /etc/hosts
fi
}

