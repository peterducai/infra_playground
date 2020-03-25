#!/bin/bash

ISO=Fedora-Server-dvd-x86_64-31-1.9.iso
URL=https://download.fedoraproject.org/pub/fedora/linux/releases/31/Server/x86_64/iso/${ISO}
systemctl enable --now libvirtd


if test -f "/tmp/${ISO}"; then
    echo "$FILE exist"
else
    wget ${URL} /tmp/${ISO}
fi




# osinfo-query os

for name in master slave1 slave2 slave3
do
    virt-install --name=${name} 
    --vcpus=1 \
    --memory=2048 \
    --cdrom=/tmp/${ISO} \
    --disk size=10 \
    --os-variant=fedora31
done