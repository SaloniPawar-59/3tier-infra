# 3-Tier Infrastructure Deployment on AWS using Terraform

##  Project Overview

This project deploys a 3-Tier architecture on AWS using Terraform Modules and optionally configures software using Ansible. It includes:
- VPC with public and private subnets
- Web & App EC2 instances
- RDS MySQL instance
- Apache/PHP application with form submission

---

##  Prerequisites

- AWS account with CLI configured
- IAM role with necessary permissions (EC2, RDS, VPC, S3, etc.)
- Terraform v1.4+ installed
- Key Pair for SSH access to instances

---

##  Deployment Steps

```bash
# Clone the repo
git clone https://github.com/SaloniPawar-59/3tier-infra.git
cd 3tier-infra/environments/dev

# Initialize Terraform
terraform init

# Validate the config
terraform validate

# Apply the configuration
terraform apply -auto-approve

How the System Works
VPC Module: Creates VPC, subnets, IGW, route tables.

EC2 Module: Launches Web and App EC2 instances into appropriate subnets.

RDS Module: Creates a private MySQL RDS instance.

User Flow:

User accesses submit.html on the Web EC2 instance.

Form sends POST request to App EC2's private IP.

PHP script in App EC2 saves data to RDS
