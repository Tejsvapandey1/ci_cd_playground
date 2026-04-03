variable "key_name" {
  description = "Name of an existing AWS EC2 key pair"
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}
