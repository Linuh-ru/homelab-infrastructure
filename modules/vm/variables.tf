variable "vm_name" { type = string }
variable "target_node" { type = string }
variable "template_name" { type = string }
variable "cpu_count" { type = number; default = 2 }
variable "ram_mb" { type = number; default = 4096 }
variable "disk_size_gb" { type = number; default = 50 }
variable "bridge_name" { type = string; default = "vmbr0" }
variable "ssh_public_key" { type = string }
variable "timezone" { type = string; default = "Europe/Moscow" }
