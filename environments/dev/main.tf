provider "aws" {
  region = "ap-south-1"
}

# VPC Module
module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

# Security Groups
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name   = "app-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web EC2
module "web" {
  source              = "../../modules/ec2"
  ami_id              = var.ami_id
  instance_type       = "t2.micro"
  subnet_id           = module.vpc.public_subnet_ids[0]
  security_group_id   = aws_security_group.web_sg.id
  key_name            = var.key_name
  user_data_file      = "${path.module}/web-user-data.sh"
  name                = "web-tier"
  associate_public_ip = true
}

# App EC2
module "app" {
  source              = "../../modules/ec2"
  ami_id              = var.ami_id
  instance_type       = "t2.micro"
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = aws_security_group.app_sg.id
  key_name            = var.key_name
  user_data_file      = "${path.module}/app-user-data.sh"
  name                = "app-tier"
}

# RDS MySQL
module "rds" {
  source            = "../../modules/rds"
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = aws_security_group.db_sg.id
  app_sg_id         = module.app.sg_id
  db_name           = var.db_name
  db_user           = var.db_user
  db_pass           = var.db_pass
  vpc_id            = module.vpc.vpc_id
}

output "web_public_ip" {
  value = module.web.public_ip
}

output "app_private_ip" {
  value = module.app.private_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
