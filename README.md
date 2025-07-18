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
- (Optional) Ansible installed for provisioning
- Key Pair for SSH access to instances

---

## 🛠️ Deployment Steps

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
