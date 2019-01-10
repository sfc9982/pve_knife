#!/bin/bash
RemoveLoginBrand() {
    cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
    sed -i "s#data.status !== 'Active'#false#g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
}

InstallBasicComponent() {
    apt install vim wget curl htop git axel aria2 apt-transport-https ca-certificates curl software-properties-common gnupg2 -y
}

ReplaceEnterpriseSource() {
    if [ -f "/etc/apt/sources.list.d/pve-enterprise.list"  ]; then
    mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak
    echo -e 'deb http://download.proxmox.com/debian/pve stretch pve-no-subscription\n' > /etc/apt/sources.list.d/pve-community.list
    fi
    echo "Source replacement already complete"
}

ReplaceDebianUpdateRepo() {
    cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb https://mirrors.aliyun.com/debian-security stretch/updates main
deb-src https://mirrors.aliyun.com/debian-security stretch/updates main
deb https://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
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

AddConfirmForDangerCommand() {
# Confirm For rm
if [ `grep -cx "alias rm='rm -i'" ~/.bashrc` != '0' ]; then
	echo 'Done'
else
    echo "alias rm='rm -i'" >> ~/.bashrc
fi
# Confirm For cp
if [ `grep -cx "alias cp='cp -i'" ~/.bashrc` != '0' ]; then
	echo 'Done'
else
    echo "alias cp='cp -i'" >> ~/.bashrc
fi
# Confirm For mv
if [ `grep -cx "alias mv='mv -i'" ~/.bashrc` != '0' ]; then
	echo 'Done'
else
    echo "alias mv='mv -i'" >> ~/.bashrc
fi
    source ~/.bashrc
}

SSHLoginAccelerate() {
    grep 'UseDNS' /etc/ssh/sshd_config
    grep 'GSSAPIAuthentication' /etc/ssh/sshd_config
    sed -i '/#UseDNS yes/aUseDNS no' /etc/ssh/sshd_config
    sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config
    grep 'UseDNS' /etc/ssh/sshd_config
    grep 'GSSAPIAuthentication' /etc/ssh/sshd_config

}

BoostNow() {
    echo '#####PVE Boost Script#####'
    echo "Let's do some choice"
while :; do echo
                read -e -p "Do you want to add Proxmox Update Accelerator? [y/n]: " ChoiceAccelerator
                if [[ ! ${ChoiceAccelerator} =~ ^[y,n]$ ]]; then
                  echo "${CWARNING}input error! Please only input 'y' or 'n'"
                else
                  break
                fi
              done
while :; do echo
                read -e -p "After replace files,Upgrade your system? [y/n]: " ChoiceUpdate
                if [[ ! ${ChoiceUpdate} =~ ^[y,n]$ ]]; then
                  echo "${CWARNING}input error! Please only input 'y' or 'n'"
                else
                  break
                fi
              done
    echo "That's all.Press any key to start...or Press Ctrl+C to cancel."
    char=$(get_char)
    ReplaceEnterpriseSource
    ReplaceDebianUpdateRepo
    RemoveLoginBrand
    UpdateRepo
    InstallBasicComponent
    AddConfirmForDangerCommand
    SSHLoginAccelerate
if [ "${ChoiceAcceleratorn}" == 'y' ]; then
    AddReserveProxy
fi
if [ "${ChoiceUpdate}" == 'y' ]; then
    UpgradeSoftware
fi
    echo '#####PVE Boost Script#####'
    echo 'All Done Enjoy It'    
}