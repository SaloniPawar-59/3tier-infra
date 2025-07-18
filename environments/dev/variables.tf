variable "vpc_cidr" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {}

variable "db_name" {}
variable "db_user" {}
variable "db_pass" {}
