locals {
  nodes = [
    { name = "k8s-master-1", role = "master", ram = 4096 },
    { name = "k8s-worker-1",  role = "worker", ram = 8192 },
    { name = "k8s-worker-2",  role = "worker", ram = 8192 }
  ]
}
module "k8s_nodes" {
  for_each = { for n in local.nodes : n.name => n }
  source = "../../modules/vm"
  vm_name = each.value.name; target_node = "pve1"
  template_name = "ubuntu-22.04-cloudinit"
  cpu_count = 2; ram_mb = each.value.ram; disk_size_gb = 50
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDNFS/V1SJPBiPnNG3/jKQCXedhEyr5EjGjJKzKJzbkA Linuh.ru@yandex.ru"
}
