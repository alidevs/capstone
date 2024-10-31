resource "alicloud_instance" "redis" {
  instance_name   = "ali-capstone-redis"
  instance_type   = "ecs.g6.large"
  image_id        = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups = [alicloud_security_group.private.id]
  vswitch_id      = alicloud_vswitch.private.id

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  user_data = base64encode(file("scripts/setup_redis.sh"))

  instance_charge_type = "PostPaid"
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_instance" "mysql" {
  instance_name   = "ali-capstone-mysql"
  instance_type   = "ecs.g6.large"
  image_id        = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups = [alicloud_security_group.private.id]
  vswitch_id      = alicloud_vswitch.private.id

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  user_data = base64encode(file("scripts/setup_mysql.sh"))

  instance_charge_type = "PostPaid"
  internet_charge_type = "PayByTraffic"
}
