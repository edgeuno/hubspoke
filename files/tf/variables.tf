
variable "pve_api" {
  type        = string
  description = "PVE API url"
  default = "null"
}

variable "pve_user" {
  type        = string
  description = "PVE username"
  default = "null"
}

variable "pve_password" {
  type        = string
  description = "PVE password"
  default = "null"
}

variable "pve_node" {
  type        = string
  description = "PVE hostname"
  default = "null"
}

variable "ssh_username" {
  type        = string
  description = "SSH username to inject from cloud-init"
  default = "null"
}

variable "ssh_private_key" {
  type        = string
  description = "SSH private key to inject from cloud-init"
  default = "null"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to inject from cloud-init"
  default = "null"
}

variable "pve_internal_vmbr" {
  type        = string
  description = "PVE bridge for Internal comunication"
  default = "null"
}

variable "pve_external_vmbr" {
  type        = string
  description = "PVE bridge for external comunication"
  default = "null"
}

variable "pve_oam_vmbr" {
  type        = string
  description = "PVE bridge for OAM"
  default = "null"
}

variable "node_config" {
  type = list(object({
    vmid = number
    name = string
    image = string
    cores = number
    sockets = number
    memory = number
    disk_size = string
    ip_address = string
    ip_gateway = string
  }))
}

variable "worker_config" {
  type = list(object({
    name = string
    ip_address = string
    ip_gateway = string
    vmid = number
  }))
}

variable "firewall_config" {
  type = list(object({
    name = string
    ip_address = string
    ip_gateway = string
    vmid = number

  }))
}

variable "proxy_config" {
  type = list(object({
    name = string
    ip_address = string
    ip_gateway = string
    vmid = number
  }))
}