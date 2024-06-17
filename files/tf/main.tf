terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = var.pve_api
    pm_user = var.pve_user
    pm_password = var.pve_password
    # pm_api_token_id = 
    # pm_api_token_secret = 
    pm_debug = true
}

