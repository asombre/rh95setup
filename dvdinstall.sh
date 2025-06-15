#!/bin/bash

os=rhel
major=9
minor=5
vmname=vm-$(date +%s)
cpunum=4
memnum=4096
dsknum=10
imgpath=/var/lib/libvirt/images
isopath=$imgpath/$os-$major.$minor-x86_64-dvd.iso
diskpath=$imgpath/$vmname.qcow2,size=$dsknum
ksfile=dvdinstall.ks
kspath=${PWD}/$ksfile

virt-install \
    --name $vmname \
    --vcpus $cpunum \
    --memory $memnum \
    --location $isopath \
    --disk $diskpath \
    --initrd-inject $kspath \
    --extra-args inst.ks="file:/$ksfile" \
    --osinfo $os$major.$minor
