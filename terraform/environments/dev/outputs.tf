########################################
# VPC Outputs
########################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}





########################################
# S3 Outputs
########################################

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.s3.bucket_id
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}





########################################
# IAM Outputs
########################################

output "iam_role_name" {
  description = "Name of the IAM Role"
  value       = module.iam.role_name
}

output "iam_role_arn" {
  description = "ARN of the IAM Role"
  value       = module.iam.role_arn
}

output "instance_profile_name" {
  description = "Name of the IAM Instance Profile"
  value       = module.iam.instance_profile_name
}

output "instance_profile_arn" {
  description = "ARN of the IAM Instance Profile"
  value       = module.iam.instance_profile_arn
}