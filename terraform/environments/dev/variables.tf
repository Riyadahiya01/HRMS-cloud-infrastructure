variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_app_subnets" {
  description = "Private application subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_db_subnets" {
  description = "Private database subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}



variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}