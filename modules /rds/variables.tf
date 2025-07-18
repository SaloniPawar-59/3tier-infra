variable "subnet_ids" {}
variable "security_group_id" {}
variable "db_name" {}
variable "db_user" {}
variable "db_pass" {}
variable "app_sg_id" {
  description = "Security group ID of the App EC2 instance"
  type        = string
}
variable "vpc_id" {
  type        = string
  description = "VPC ID for RDS security group"
}
