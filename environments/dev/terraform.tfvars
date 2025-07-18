vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs             = ["ap-south-1a", "ap-south-1b"]

ami_id    = "ami-0a1235697f4afa8a4"  # Example: Amazon Linux 2 (change based on region)
key_name  = "rds"

db_name = "registration"
db_user = "admin"
db_pass = "StrongPassword123!"
