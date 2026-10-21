variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_allowed_cidr" {
  type = string
}

variable "web_port" {
  type    = number
  default = 80
}
