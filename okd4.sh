#!/bin/bash


QCOWxz=fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz
QCOW=fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2
URL=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/${QCOWxz}

systemctl enable --now libvirtd


if test -f "/tmp/${QCOWxz}"; then
    echo "$FILE exist"
else
    wget ${URL} /tmp/${QCOWxz}
fi

xz -v -d /tmp/${QCOWxz}
cp -v /tmp/${QCOWxz} /var/lib/libvirt/images/${QCOW}
qemu-img resize /var/lib/libvirt/images/${QCOW} 20G

# inject SSH key
sudo virt-sysprep -a /var/lib/libvirt/images/${QCOW} --run-command 'useradd vivek' --ssh-inject centos:file:/home/vivek/.ssh/id_rsa.pub

virt-install --import \
--name centos7-vm1 \
--memory 1024 \
--vcpus 2 \
--cpu host \
--disk path=/var/lib/libvirt/images/centos7.qcow2,size=10,bus=virtio,format=qcow \
--os-type=linux \
--os-variant=centos7.0 \
--graphics spice \
--noautoconsole \
--disk /home/vivek/modifyisoimages/CentOS-7-x86_64-GenericCloud.qcow2

$ virsh net-list
$ virsh net-dhcp-leases default
$ ssh vivek@vms-ip-address-here

# osinfo-query os

# for name in bootstrap control1 compute1 compute2
# do
#     virt-install --name=${name} 
#     --vcpus=1 \
#     --memory=2048 \
#     --cdrom=/tmp/${QCOW} \
#     --disk size=10 \
#     --os-variant=fedora31
# done

# https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz