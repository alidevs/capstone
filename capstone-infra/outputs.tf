output "load_balancer_domain" {
  value       = alicloud_nlb_load_balancer.main.dns_name
  description = "The domain name of the load balancer"
}

output "bastion_public_ip" {
  value = alicloud_instance.bastion.public_ip
}

output "http_server_private_ips" {
  value = alicloud_instance.http_servers[*].private_ip
}

output "mysql_private_ip" {
  value = alicloud_instance.mysql.private_ip
}

output "redis_private_ip" {
  value = alicloud_instance.redis.private_ip
}
