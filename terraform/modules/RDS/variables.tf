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

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

#################################################
# Database Configuration
#################################################

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
}

#################################################
# Networking
#################################################

variable "private_db_subnet_ids" {
  description = "Private database subnet IDs"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "RDS Security Group ID"
  type        = string
}