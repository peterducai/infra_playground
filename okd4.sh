#!/bin/bash


QCOW=fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz
URL=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/${QCOW}
systemctl enable --now libvirtd


if test -f "/tmp/${QCOW}"; then
    echo "$FILE exist"
else
    wget ${URL} /tmp/${QCOW}
fi

cp -v /tmp/${QCOW} /var/lib/libvirt/images/${QCOW}
qemu-img resize /var/lib/libvirt/images/${QCOW} 20G


# osinfo-query os

for name in bootstrap control1 compute1 compute2
do
    virt-install --name=${name} 
    --vcpus=1 \
    --memory=2048 \
    --cdrom=/tmp/${QCOW} \
    --disk size=10 \
    --os-variant=fedora31
done

https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz