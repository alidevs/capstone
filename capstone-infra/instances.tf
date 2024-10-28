resource "alicloud_instance" "http_servers" {
  count = 2

  instance_name   = "ali-capstone-http-server-${count.index + 1}"
  instance_type   = "ecs.g6.large"
  image_id        = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups = [alicloud_security_group.private.id]
  vswitch_id      = alicloud_vswitch.private.id

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  instance_charge_type = "PostPaid"
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_instance" "bastion" {
  instance_name   = "ali-capstone-bastion"
  instance_type   = "ecs.g6.large"
  image_id        = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups = [alicloud_security_group.public.id]
  vswitch_id      = alicloud_vswitch.public.id

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  instance_charge_type = "PostPaid"
  internet_charge_type = "PayByTraffic"
}
