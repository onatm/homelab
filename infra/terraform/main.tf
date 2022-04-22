module "k3s" {
  source       = "./modules/k3s"
  target_node  = "pve"
  ciuser       = "onatm"
  ssh_key_file = "~/.ssh/id_ed25519.pub"
}
