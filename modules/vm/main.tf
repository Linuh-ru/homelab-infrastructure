terraform {
  required_providers {
    proxmox = { source = "telmate/proxmox"; version = "~> 3.0" }
  }
}
resource "proxmox_vm_qemu" "vm" {
  name = var.vm_name
  target_node = var.target_node
  cores = var.cpu_count
  sockets = 1
  memory = var.ram_mb
  disk_gb = var.disk_size_gb
  disk_type = "scsi"
  disk_bus = "scsi0"
  network_interface { name = "eth0"; model = "virtio"; bridge = var.bridge_name; firewall = true }
  cloudinit {
    ci_user_data_base64 = base64encode(templatefile("/cloudinit.tpl", {
      ssh_authorized_keys = var.ssh_public_key
      hostname = var.vm_name
      timezone = var.timezone
    }))
    ci_meta_data_base64 = base64encode(templatefile("/meta.tpl", {
      instance_id = var.vm_name
      local_hostname = var.vm_name
    }))
  }
  clone { template_name = var.template_name; full_clone = false }
}
output "vm_id" { value = proxmox_vm_qemu.vm.id }
