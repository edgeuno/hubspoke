
resource "proxmox_vm_qemu" "worker" {
    for_each = { for each in var.worker_config : each.name => each }

    vmid = each.value.vmid
    name = format("%s-%d", each.value.name, each.value.vmid)
    desc = "Instance created from Terraform"

    target_node = var.pve_node
    # pool = "pool0"
    clone = "Ubuntu20"
    full_clone = true

    automatic_reboot = true

    lifecycle {
        create_before_destroy = true
        ignore_changes        = [agent]
    }

    agent = 0

    os_type = "cloud-init"
    qemu_os = "l26"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "kvm64"
    memory = 10240
    boot = "cdn"
    bootdisk = "scsi0"
    scsihw = "virtio-scsi-pci"
    
    vga {
        type   = "std"
        memory = 4
    }
    serial {
        id   = 1
        type = "socket"
    }
    disk {
        # slot = 0
        size = "40G"
        type = "scsi"
        storage = "SHARED_STORAGE"
        # storage_type = "lvm"
        iothread = 0
        discard = "on"
    }

    network {
        model = "virtio"
        bridge = var.pve_oam_vmbr
    }
    network {
        model = "virtio"
        bridge = var.pve_internal_vmbr
        tag = 1605
    }
    ciuser = var.ssh_username
    ipconfig0 = format("ip=%s,gw=%s", each.value.ip_address, each.value.ip_gateway)
    sshkeys = var.ssh_public_key

    provisioner "remote-exec" {
        inline = [
            "ping -c1 google.com"
        ]
        connection {
            type        = "ssh"
            user        = var.ssh_username
            private_key = file(var.ssh_private_key)
            host        = split("/", each.value.ip_address)[0]
            port        = self.ssh_port
        }   
    }
    provisioner "local-exec" {
        # when    = destroy
        command = "echo Hey from: ${self.name}"
    }
}
