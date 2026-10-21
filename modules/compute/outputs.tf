output "instance_id" {
  value = aws_instance.web.id
}

output "elastic_ip" {
  value = aws_eip.web.public_ip
}

output "web_url" {
  value = "http://${aws_eip.web.public_ip}"
}

output "iam_role_name" {
  value = aws_iam_role.ec2.name
}
