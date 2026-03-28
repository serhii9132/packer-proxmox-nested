[global]
country = "ua"
fqdn = "pve.test"
keyboard = "en-us"
mailto = "root@pve"
timezone = "UTC"
reboot-mode = "reboot"
root-password-hashed = "${var.ssh_password}"
root-ssh-keys = [
    ${var.ssh_pub_key}
]

[network]
source = "from-answer"
cidr = "${var.ip}/${var.mask}"
gateway = "${var.gateway}"
dns = "8.8.8.8"
filter.ID_VENDOR_FROM_DATABASE = "Red Hat, Inc."
filter.ID_MODEL_FROM_DATABASE = "Virtio network device"

[disk-setup]
filesystem = "ext4"
disk-list = ["sda"]
lvm.swapsize = 0
lvm.maxroot = 25
lvm.maxvz = 0