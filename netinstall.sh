#!/bin/bash

os=rhel
major=9
minor=5
vmname=$os$major$minor\net-$(date +%s)
cpunum=4
memnum=4096
repoip=x.x.x.x
imgpath=/var/lib/libvirt/images
pkgpath=http://$repoip/$os/$major.$minor/
diskpath=$imgpath/$vmname.qcow2,size=10
ksfile=netinstall.ks

virt-install \
    --name $vmname \
    --vcpus $cpunum \
    --memory $memnum \
    --location $pkgpath \
    --disk $diskpath \
    --extra-args inst.ks="http://$repoip/kickstarts/$ksfile console=tty0 console=ttyS0,115200" \
    --osinfo $os$major.$minor \
    --nographics
