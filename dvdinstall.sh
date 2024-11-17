#!/bin/bash

os=rhel
major=9
minor=5
vmname=$os$major$minor\iso-$(date +%s)
cpunum=4
memnum=4096
imgpath=/var/lib/libvirt/images
isopath=$imgpath/$os-$major.$minor-x86_64-dvd.iso
diskpath=$imgpath/$vmname.qcow2,size=10
ksfile=dvdinstall.ks
kspath=ksdir/$ksfile

virt-install \
    --name $vmname \
    --vcpus $cpunum \
    --memory $memnum \
    --location $isopath \
    --disk $diskpath \
    --initrd-inject $kspath \
    --extra-args inst.ks="file:/$ksfile console=tty0 console=ttyS0,115200" \
    --osinfo $os$major.$minor \
    --nographics 
