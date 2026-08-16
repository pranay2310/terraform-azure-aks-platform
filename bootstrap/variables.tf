variable "terraform_state_bucket" {
  description = "Terraform remote state bucket name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "owner" {
  description = "Owner Name"
  type        = string
}