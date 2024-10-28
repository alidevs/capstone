variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "public_subnet_cidr" {
  default = "172.16.1.0/24"
}

variable "private_subnet_cidr" {
  default = "172.16.2.0/24"
}

variable "mysql_root_password" {
  type      = string
  sensitive = true
}

variable "mysql_database" {
  type    = string
  default = "flaskdb"
}

variable "mysql_user" {
  type    = string
  default = "flaskuser"
}

variable "mysql_password" {
  type      = string
  sensitive = true
}
