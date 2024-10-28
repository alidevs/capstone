resource "alicloud_ecs_key_pair" "bastion" {
  key_pair_name = "ali-capstone-bastion-keypair"
  key_file      = "ali-capstone-bastion-keypair.pem"
}

