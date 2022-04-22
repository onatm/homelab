variable "target_node" {
  type        = string
  description = "node to create the VM on"
}

variable "ciuser" {
  type        = string
  description = "cloud-init user"
}

variable "ssh_key_file" {
  type        = string
  description = "ssh public key to add authorized keys file for the cloud-init user"
}
