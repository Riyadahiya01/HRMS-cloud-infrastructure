#################################################
# Project Information
#################################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

#################################################
# EC2 Configuration
#################################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size (GB)"
  type        = number
}

#################################################
# Networking
#################################################

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "EC2 Security Group ID"
  type        = string
}

#################################################
# IAM
#################################################

variable "instance_profile_name" {
  description = "IAM Instance Profile Name"
  type        = string
}

#################################################
# Tags
#################################################

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}