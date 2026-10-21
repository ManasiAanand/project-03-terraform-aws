output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "ec2_instance_id" {
  description = "ID of the web server"
  value       = module.compute.instance_id
}

output "elastic_ip" {
  description = "Public Elastic IP address"
  value       = module.compute.elastic_ip
}

output "web_url" {
  description = "URL of the deployed web server"
  value       = module.compute.web_url
}

output "iam_role_name" {
  description = "IAM role attached to EC2"
  value       = module.compute.iam_role_name
}
output "s3_bucket_name" {
  description = "Name of the application S3 bucket"
  value       = aws_s3_bucket.app.bucket
}
