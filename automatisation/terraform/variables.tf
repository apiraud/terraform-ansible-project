variable password {
  type          = string
  default       = ""
  description   = "Default password for containers"
}

variable ssh_public_keys {
  type          = string
  default       = ""
  description   = "Multiline each line a ssh-key"
}

variable target_node {
  type          = string
  default       = "cfai2024"
  description   = "Target to proxmox deployment"
}

variable pool {
  type          = string
  default       = ""
  description   = "Pool to deploy on"
}

variable containers {
  type          = list(object({
    name        = string
    cpuunits    = number
    rootfs_size = string
    memory      = number
    ostemplate  = string
    ipv6        = string
    class       = string
  }))
  default       = [{
    name        = "default"
    cpuunits    = 128
    rootfs_size = "1G"
    memory      = 128
    ostemplate  = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
    ipv6        = "auto"
    class       = ""
  }]
  description   = ""
}