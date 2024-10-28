resource "alicloud_nlb_load_balancer" "main" {
  load_balancer_name = "ali-capstone-nlb"
  address_type       = "Internet"
  load_balancer_type = "Network"
  vpc_id             = alicloud_vpc.main.id
  zone_mappings {
    vswitch_id = alicloud_vswitch.public.id
    zone_id    = data.alicloud_zones.available.zones[0].id
  }
}

resource "alicloud_nlb_server_group" "main" {
  server_group_name = "ali-capstone-http-server-group"
  vpc_id            = alicloud_vpc.main.id
}

resource "alicloud_nlb_server_group_server_attachment" "main" {
  count           = 2
  port            = 80
  server_group_id = alicloud_nlb_server_group.main.id
  server_id       = alicloud_instance.http_servers[count.index].id
  server_type     = "Ecs"
  weight          = 100
}

resource "alicloud_nlb_listener" "http" {
  load_balancer_id     = alicloud_nlb_load_balancer.main.id
  listener_protocol    = "TCP"
  listener_port        = 80
  server_group_id      = alicloud_nlb_server_group.main.id
}
