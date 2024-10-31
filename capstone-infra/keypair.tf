resource "alicloud_ecs_key_pair" "bastion" {
  key_pair_name = "ali-capstone-bastion-keypair-lx"
  key_file      = "ali-capstone-bastion-keypair-lx.pem"
}

