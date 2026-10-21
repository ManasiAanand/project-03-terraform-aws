
data "aws_availability_zones" "available" {
  state = "available"
}

# Get the AWS account ID for a unique S3 bucket name
data "aws_caller_identity" "current" {}

# Networking module: VPC, public subnets, IGW and routing
module "networking" {
  source = "./modules/networking"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs

  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )
}

# Compute module: EC2, security group, IAM and Elastic IP
module "compute" {
  source = "./modules/compute"

  project_name     = var.project_name
  vpc_id           = module.networking.vpc_id
  public_subnet_id = module.networking.public_subnet_ids[0]
  instance_type    = var.instance_type
  ssh_allowed_cidr = var.ssh_allowed_cidr
  web_port         = 80
}

# Application S3 bucket
resource "aws_s3_bucket" "app" {
  bucket = "${var.project_name}-${data.aws_caller_identity.current.account_id}-${var.aws_region}"

  tags = {
    Name        = "${var.project_name}-app-bucket"
    Environment = "learning"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable S3 bucket versioning
resource "aws_s3_bucket_versioning" "app" {
  bucket = aws_s3_bucket.app.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable default server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

