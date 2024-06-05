resource "proxmox_lxc" "infracoston" {

  for_each = { for cont in var.containers : cont.name => cont }

  target_node  = var.target_node
  pool         = var.pool
  hostname     = each.value.name
  password     = var.password
  ssh_public_keys = var.ssh_public_keys
  cpuunits     = each.value.cpuunits
  memory       = each.value.memory
  ostemplate   = each.value.ostemplate

  start        = true
  onboot       = true
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = each.value.rootfs_size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    ip6    = each.value.ipv6
  }

  provisioner "local-exec" {
    command = "sh install.sh ${each.value.class} ${each.value.name}"
  }

}
