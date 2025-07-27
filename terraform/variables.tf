variable "aws_region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
}

variable "docker_username" {
  description = "DockerHub username"
  type        = string
}

variable "docker_password" {
  description = "DockerHub password or token"
  type        = string
  sensitive   = true
}
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}
variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "Startup script for EC2"
  type        = string
}
