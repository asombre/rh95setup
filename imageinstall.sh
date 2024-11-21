#!/bin/bash

kvmdir="/var/lib/libvirt/images"
qcowimg="rhel-9.5-x86_64-kvm.qcow2"
os_ver=rhel9.5
vmname=rhel95kvm-$(date +%s)

echo "creating... $kvmdir/$vmname"
cp $kvmdir/$qcowimg $kvmdir/$vmname.qcow2

echo "exporting..."
export LIBGUESTFS_BACKEND=direct

echo "creating kvm image..."
virt-customize -a $kvmdir/$vmname.qcow2 \
--root-password password:password1234 \
--hostname $vmname \
--copy-in scripts/userpass.sh:/root \
--copy-in scripts/sshkeygen.sh:/root \
--copy-in scripts/my.repo:/etc/yum.repos.d/ \
--firstboot-command 'useradd user -s /bin/bash -c "First Last"' \
--firstboot-command 'yum clean all; yum makecache' \
--firstboot-command 'vim-enhanced' \
--uninstall cloud-init

echo "changing owner..."
chown qemu:qemu $kvmdir/$vmname.qcow2

echo "creating 10G VM $vmname..."
virt-install \
    --name $vmname \
    --memory 4096 \
    --vcpus 4 \
    --disk $kvmdir/$vmname.qcow2 \
    --import \
    --os-variant $os_ver

echo "done"
