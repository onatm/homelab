#!/usr/bin/env bash

set -euo pipefail

function cleanup { :; }

trap "cleanup" EXIT

# download cloud-init ubuntu image
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# create a VM to use for template creation
qm create 9000 --name "ubuntu-2204-cloudinit-template" --memory 2048 --net0 virtio,bridge=vmbr0

# import disk image
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm

# configure VM to use imported image
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

# add cloud-init image as CDROM
qm set 9000 --ide2 local-lvm:cloudinit

# configure boot from the image
qm set 9000 --boot c --bootdisk scsi0

# attach serial console
qm set 9000 --serial0 socket --vga serial0

# create template
qm template 9000
