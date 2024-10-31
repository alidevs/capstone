resource "alicloud_vpc" "main" {
  vpc_name   = "ali-capstone-vpc"
  cidr_block = var.vpc_cidr
}

resource "alicloud_vswitch" "public" {
  vswitch_name = "ali-capstone-public-subnet"
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = var.public_subnet_cidr
  zone_id      = data.alicloud_zones.available.zones.0.id
}

resource "alicloud_vswitch" "private" {
  vswitch_name = "ali-capstone-private-subnet"
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = var.private_subnet_cidr
  zone_id      = data.alicloud_zones.available.zones.0.id
}

resource "alicloud_nat_gateway" "main" {
  vpc_id           = alicloud_vpc.main.id
  nat_gateway_name = "ali-capstone-nat"
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.public.id
  nat_type         = "Enhanced"
}

resource "alicloud_eip" "nat" {
  bandwidth = "10"
}

resource "alicloud_eip_association" "nat" {
  allocation_id = alicloud_eip.nat.id
  instance_id   = alicloud_nat_gateway.main.id
}

resource "alicloud_route_table" "private" {
  vpc_id           = alicloud_vpc.main.id
  route_table_name = "private-rt"
}

resource "alicloud_route_entry" "internet" {
  route_table_id        = alicloud_route_table.private.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alicloud_nat_gateway.main.id
  
  depends_on = [
    alicloud_nat_gateway.main,
    alicloud_eip_association.nat
  ]
}

resource "alicloud_route_table_attachment" "private" {
  vswitch_id     = alicloud_vswitch.private.id
  route_table_id = alicloud_route_table.private.id
}

resource "alicloud_snat_entry" "private" {
  snat_table_id     = alicloud_nat_gateway.main.snat_table_ids
  source_vswitch_id = alicloud_vswitch.private.id
  snat_ip           = alicloud_eip.nat.ip_address
}
