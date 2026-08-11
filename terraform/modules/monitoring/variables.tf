#################################################
# Monitoring Variables
#################################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}