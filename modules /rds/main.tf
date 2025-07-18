resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name                 = var.db_name
  username             = var.db_user
  password             = var.db_pass
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.app_sg_id]
  skip_final_snapshot = true
}
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL access from app tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.app_sg_id] # <-- reference to app EC2 SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
  }
}
