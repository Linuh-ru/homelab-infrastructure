module "gitlab_vm" {
  source = "../../modules/vm"
  vm_name = "gitlab-server"; target_node = "pve1"
  template_name = "ubuntu-22.04-cloudinit"
  cpu_count = 4; ram_mb = 8192; disk_size_gb = 100
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDNFS/V1SJPBiPnNG3/jKQCXedhEyr5EjGjJKzKJzbkA Linuh.ru@yandex.ru"
}
