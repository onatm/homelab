resource "proxmox_vm_qemu" "master" {
  count       = 1
  name        = "master.k3s.cluster"
  target_node = var.pm_node

  clone = "ubuntu-2204-cloudinit-template"

  os_type  = "cloud-init"
  cores    = 1
  sockets  = "1"
  cpu      = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    size     = "20G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0 = "ip=192.168.0.200/24,gw=192.168.0.1"
  ciuser    = var.ciuser
  sshkeys   = file("${var.ssh_key_file}")
}

resource "proxmox_vm_qemu" "nodes" {
  count       = 3
  name        = "node-${count.index}.k8s.cluster"
  target_node = var.pm_node

  clone = "ubuntu-2204-cloudinit-template"

  os_type  = "cloud-init"
  cores    = 1
  sockets  = "1"
  cpu      = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    size     = "20G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0 = "ip=192.168.0.21${count.index}/24,gw=192.168.0.1"
  ciuser    = var.ciuser
  sshkeys   = file("${var.ssh_key_file}")
}
