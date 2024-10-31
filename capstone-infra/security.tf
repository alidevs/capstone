resource "alicloud_security_group" "private" {
  name   = "ali-capstone-private-sg"
  vpc_id = alicloud_vpc.main.id
}

# Redis ingress from HTTP servers
resource "alicloud_security_group_rule" "redis_from_http" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  port_range               = "6379/6379"
  security_group_id        = alicloud_security_group.private.id
  source_security_group_id = alicloud_security_group.public.id
}

# MySQL ingress from HTTP servers
resource "alicloud_security_group_rule" "mysql_from_http" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  port_range               = "3306/3306"
  security_group_id        = alicloud_security_group.private.id
  source_security_group_id = alicloud_security_group.public.id
}

resource "alicloud_security_group" "public" {
  name   = "ali-capstone-public-sg"
  vpc_id = alicloud_vpc.main.id
}

# SSH access to bastion from anywhere
resource "alicloud_security_group_rule" "ssh_to_bastion" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  security_group_id = alicloud_security_group.public.id
  cidr_ip           = "0.0.0.0/0"
}

# SSH from bastion to private instances
resource "alicloud_security_group_rule" "ssh_from_bastion" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  port_range               = "22/22"
  security_group_id        = alicloud_security_group.private.id
  source_security_group_id = alicloud_security_group.public.id
}

# Allow all outbound traffic
resource "alicloud_security_group_rule" "private_outbound" {
  type              = "egress"
  ip_protocol       = "all"
  port_range        = "-1/-1"
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "public_outbound" {
  type              = "egress"
  ip_protocol       = "all"
  port_range        = "-1/-1"
  security_group_id = alicloud_security_group.public.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http_from_nlb" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http_egress" {
  type              = "egress"
  ip_protocol       = "all"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_lb_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.private.id
  cidr_ip           = "0.0.0.0/0"
}
