variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_id" {}
variable "user_data_file" {}
variable "key_name" {}
variable "name" {}
variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}
