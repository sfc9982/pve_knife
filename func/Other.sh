#!/bin/bash
RemoveLoginBrand() {
    cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
    sed -i "s#data.status !== 'Active'#false#g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
}

InstallBasicComponent() {
    apt install vim wget curl htop git axel aria2 -y
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