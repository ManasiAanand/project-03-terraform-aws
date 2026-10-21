
Project 03 — Terraform AWS Infrastructure and GitHub Actions CI/CD

Overview

This project provisions AWS infrastructure using Terraform and automates infrastructure validation, planning, and deployment using GitHub Actions.

The application is hosted on an Ubuntu EC2 instance running Nginx. Terraform manages the infrastructure, while an S3 backend stores the Terraform state remotely.

Architecture

The project provisions:

A custom VPC with CIDR 10.0.0.0/16

Two public subnets

An Internet Gateway, public route table, and subnet associations

A security group allowing HTTP access and optional restricted SSH access

An Ubuntu EC2 web server with Nginx installed through User Data

An Elastic IP for the web server

An application S3 bucket with versioning, encryption, and public-access protection

An IAM role and instance profile for EC2

An S3 remote-state bucket with versioning, encryption, public-access blocking, and Terraform state locking

Live Application

Application URL: http://15.252.205.184

The landing page confirms that the Nginx web server is accessible through the Elastic IP.

Terraform Modules

modules/networking: VPC, public subnets, Internet Gateway, route table, and route associations

modules/compute: EC2 instance, security group, IAM role and instance profile, and Elastic IP

Repository Structure

.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
├── .gitignore
├── .terraform.lock.hcl
└── modules/
    ├── networking/
    └── compute/

Prerequisites

Terraform 1.10 or later

AWS CLI

An AWS identity with the permissions required to provision the infrastructure

A GitHub repository with the following Actions secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Terraform Validation

Run the following commands from the project directory:

terraform fmt -check -recursive
terraform init
terraform validate
terraform plan

CI/CD Workflow

The GitHub Actions workflow automates:

Checking out the repository

Configuring AWS credentials from GitHub Secrets

Checking Terraform formatting

Initializing the Terraform backend

Validating the Terraform configuration

Generating a Terraform plan

Uploading the plan as a workflow artifact

Running the infrastructure deployment job when manually triggered on the main branch

Displaying Terraform outputs and checking application availability

The production environment restricts deployments to the main branch.

Terraform Outputs

The configuration exposes:

VPC ID

Public subnet IDs

EC2 instance ID

Elastic IP

Application URL

IAM role name

Application S3 bucket name

Security

Terraform state files are excluded from Git.

Remote state is stored in a dedicated S3 bucket.

S3 bucket versioning and server-side encryption are enabled.

Public access is blocked on both S3 buckets.

AWS credentials are stored in GitHub Secrets rather than committed to source control.

SSH access is restricted through a configurable CIDR.

The EC2 instance requires IMDSv2.

Evidence

The following evidence is available from the project:

Successful GitHub Actions workflow run

Terraform plan artifact

AWS VPC and Internet Gateway

EC2 instance and Elastic IP

Application S3 bucket security settings

Terraform remote-state bucket security settings

IAM role attached to the EC2 instance

Working application landing page

Cleanup

After collecting the required evidence, remove the Terraform-managed infrastructure using terraform destroy from the initialized project directory if the resources are no longer required. Confirm the plan carefully before approving destruction.

The remote-state S3 bucket is separate from the application infrastructure and may need to be cleaned up separately after Terraform no longer depends on it.
