variable "pm_node" {
  default = "pve"
}

variable "pm_user" {
  default = "root@pam"
}

variable "pm_password" {
  default = ""
}

variable "ciuser" {
  default = ""
}

variable "ssh_key_file" {
  default = "~/.ssh/id_ed25519.pub"
}
