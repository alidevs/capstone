resource "alicloud_security_group" "private" {
  name   = "ali-capstone-private-sg"
  vpc_id = alicloud_vpc.main.id
}

resource "alicloud_security_group_rule" "redis_from_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "6379/6379"
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = var.private_subnet_cidr
}

resource "alicloud_security_group_rule" "mysql_from_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3306/3306"
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = var.private_subnet_cidr
}

resource "alicloud_security_group" "public" {
  name   = "ali-capstone-public-sg"
  vpc_id = alicloud_vpc.main.id
}

resource "alicloud_security_group_rule" "ssh_to_bastion" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  security_group_id = alicloud_security_group.public.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh_from_bastion" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  port_range               = "22/22"
  security_group_id        = alicloud_security_group.private.id
  source_security_group_id = alicloud_security_group.public.id
}
