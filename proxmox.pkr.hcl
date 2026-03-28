packer {
  required_plugins {
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "proxmox-iso" "pve" {
    proxmox_url               = var.proxmox_url
    insecure_skip_tls_verify  = true
    username                  = var.pve_username
    token                     = var.pve_token
    node                      = var.pve_node_name
    task_timeout              = "15m"

    vm_name                   = "proxmox-9.1"
    os                        = "l26"
    cpu_type                  = "host"
    cores                     = 2
    sockets                   = 1
    memory                    = 6144
    scsi_controller           = "virtio-scsi-single"
    serials                   = ["socket"]
    communicator              = "ssh"

    bios                      = "seabios"

    disks {
        storage_pool            = "local"
        disk_size               = "100G"
        format                  = "qcow2"
        io_thread               = true
        type                    = "scsi"
    }

    network_adapters {
        model                   = "virtio"
        bridge                  = "vmbr1"
        vlan_tag                = "10"
    }

    boot_iso {
        type                    = "scsi"
        iso_download_pve        = true
        iso_storage_pool        = "local"
        iso_url                 = "${local.iso_url}/${local.iso_file}"
        iso_checksum            = "sha256:${local.iso_checksum}"
        unmount                 = true
    }

    additional_iso_files { 
        type                    = "scsi"
        cd_content              = local.unattended
        cd_label                = local.cd_files
        iso_storage_pool        = "local"
        unmount                 = true
    }

    ssh_host                  = var.ip
    ssh_username              = "root"
    ssh_private_key_file      = var.ssh_private_key_file
    ssh_timeout               = "4m"

    boot_wait                 = "10s"
    boot_command = [
        "<down><down><down><enter>",
        "<down><down><down><enter>",
        "<wait30s>",
        "proxmox-fetch-answer partition ${local.cd_files} > /run/automatic-installer-answers<enter><wait>exit<enter>",
        "<wait3m>"
    ]
}

build {
    sources = ["sources.proxmox-iso.pve"]
}