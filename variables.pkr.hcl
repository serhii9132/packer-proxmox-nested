locals {
    output_directory = "builds/${formatdate("YYYY-MM-DD_hh-mm", timestamp())}"

    iso_url = "https://enterprise.proxmox.com/iso"
    iso_file = "proxmox-ve_9.1-1.iso"
    iso_checksum = "6d8f5afc78c0c66812d7272cde7c8b98be7eb54401ceb045400db05eb5ae6d22"

    answer_filename = "answer.toml"
    cd_files = "cidata"
    unattended = {
      "/${local.answer_filename}" = templatefile(abspath("${path.root}/${local.cd_files}/answer.toml.pkrtpl.hcl"), { var = var })
    }
}

variable "proxmox_url" {
    type = string
    default = env("PROXMOX_URL")
}

variable "pve_username" {
    type = string
    default = env("PROXMOX_USER")
}

variable "pve_token" {
    type = string
    default = env("PROXMOX_TOKEN")
}

variable "pve_node_name" {
    type = string
    default = env("PROXMOX_NAME_NODE")
}

variable "ssh_password" {
    type = string
    default = env("PASSWORD")
}

variable "ssh_pub_key" {
    type = string
    default = env("SSH_PUBLIC_KEY")
}

variable "ssh_private_key_file" {
    type = string
    default = env("SSH_PRIVATE_KEY_FILE")
}

variable "ip" {
    type = string
    default = env("IP")
}

variable "mask" {
    type = string
    default = env("MASK")
}

variable "gateway" {
    type = string
    default = env("GATEWAY")
}