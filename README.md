# Project 03 — Terraform AWS Infrastructure

## Overview
This project provisions AWS infrastructure using Terraform and automates validation and deployment using GitHub Actions.

## Architecture
- VPC with two public subnets
- Internet Gateway and public route table
- Security group for HTTP access and optional restricted SSH
- EC2 Ubuntu web server with Nginx User Data
- Elastic IP for the web server
- Application S3 bucket with versioning, encryption, and public-access protection
- IAM role and instance profile for EC2
- S3 remote Terraform state with versioning and state locking

## Terraform Modules
- `modules/networking`: VPC, subnets, Internet Gateway, routing
- `modules/compute`: EC2, security group, IAM role/profile, Elastic IP

## Repository Structure
```text
.
├── .github/workflows/terraform.yml
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
└── modules/
    ├── networking/
    └── compute/
```

## Prerequisites
- Terraform 1.10 or later
- AWS CLI configured with suitable IAM permissions
- GitHub repository secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

## Validation
```bash
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan
```

## Deployment
GitHub Actions runs formatting, initialization, validation, and planning. Review the plan before triggering infrastructure deployment. Do not deploy until the approval process and remote backend are verified.

## Outputs
- VPC ID
- Public subnet IDs
- EC2 instance ID
- Elastic IP
- Web URL
- IAM role name
- Application S3 bucket name

## Security
- Terraform state is excluded from Git.
- The remote state bucket has versioning, encryption, and public-access blocking.
- AWS credentials are stored in GitHub Secrets, not in source files.
- SSH access should be restricted to a trusted IP address.

## Evidence
Add screenshots of the GitHub Actions workflow, plan artifact, AWS resources, S3 security settings, and working web page after deployment.
