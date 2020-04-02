#!/bin/bash


COS_f31_QCOWxz=fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz
QCOW=fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2
URL=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/${COS_f31_QCOWxz}

systemctl enable --now libvirtd


if test -f "/tmp/${COS_f31_QCOWxz}"; then
    echo "$FILE exist"
else
    wget ${URL} /tmp/${COS_f31_QCOWxz}
fi

unxz /tmp/${COS_f31_QCOWxz}
cp -v /tmp/${COS_f31_QCOWxz} /var/lib/libvirt/images/${COS_f31_QCOW}
qemu-img resize /var/lib/libvirt/images/${COS_f31_QCOW} 20G


chcon -t svirt_home_t path/to/example.ign


# Example launching FCOS with QEMU (temporary storage)

# qemu-kvm -m 2048 -cpu host -nographic -snapshot \
# 	-drive if=virtio,file=fedora-coreos-qemu.qcow2 \
# 	-fw_cfg name=opt/com.coreos/config,file=path/to/example.ign

# Example launching FCOS with QEMU (persistent storage)

qemu-img create -f qcow2 -b /var/lib/libvirt/images/${COS_f31_QCOW} /var/lib/libvirt/images/${new_disk}.qcow2
qemu-kvm -m 2048 -cpu host -nographic \
	-drive if=virtio,file=my-fcos-vm.qcow2 \
	-fw_cfg name=opt/com.coreos/config,file=path/to/example.ign

# Example launching FCOS with virt-install

# virt-install --connect qemu:///system -n fcos -r 2048 --os-variant=fedora31 --import \
# 	--graphics=none --disk size=10,backing_store=/path/to/fedora-coreos-qemu.qcow2 \
# 	--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=/path/to/example.ign"



# inject SSH key
# sudo virt-sysprep -a /var/lib/libvirt/images/${COS_f31_QCOW} --run-command 'useradd vivek' --ssh-inject centos:file:/home/vivek/.ssh/id_rsa.pub

# virt-install --import \
# --name centos7-vm1 \
# --memory 1024 \
# --vcpus 2 \
# --cpu host \
# --disk path=/var/lib/libvirt/images/centos7.qcow2,size=10,bus=virtio,format=qcow \
# --os-type=linux \
# --os-variant=centos7.0 \
# --graphics spice \
# --noautoconsole \
# --disk /home/vivek/modifyisoimages/CentOS-7-x86_64-GenericCloud.qcow2

# $ virsh net-list
# $ virsh net-dhcp-leases default
# $ ssh vivek@vms-ip-address-here

# osinfo-query os

# for name in bootstrap control1 compute1 compute2
# do
#     virt-install --name=${name} 
#     --vcpus=1 \
#     --memory=2048 \
#     --cdrom=/tmp/${COS_f31_QCOW} \
#     --disk size=10 \
#     --os-variant=fedora31
# done

# https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200310.3.0/x86_64/fedora-coreos-31.20200310.3.0-qemu.x86_64.qcow2.xz