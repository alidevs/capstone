resource "alicloud_kvstore_instance" "redis" {
  db_instance_name = "ali-capstone-redis"
  vswitch_id       = alicloud_vswitch.private.id
  security_ips     = [var.private_subnet_cidr]
  instance_type    = "Redis"
  engine_version   = "5.0"
  zone_id          = data.alicloud_zones.available.zones[0].id
  instance_class   = "redis.master.small.default"
}

resource "alicloud_db_instance" "mysql" {
  instance_name    = "ali-capstone-mysql"
  engine           = "MySQL"
  engine_version   = "8.0"
  instance_type    = "mysql.n2.medium.2c"
  instance_storage = "20"
  vswitch_id       = alicloud_vswitch.private.id
  security_ips     = [var.private_subnet_cidr]
  zone_id          = data.alicloud_zones.available.zones[0].id
}
