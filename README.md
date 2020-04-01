# infra_playground


# Cloud init

> :warning: **It’s important to NOT install cloud-init on your KVM host machine.**

This creates a cloud-init service that runs during the boot and tries to reconfigure your host. Something that you probably don’t want on your KVM hypervisor host.


> yum install -y cloud-utils