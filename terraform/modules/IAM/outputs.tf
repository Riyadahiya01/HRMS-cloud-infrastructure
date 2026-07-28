########################################
# IAM Outputs
########################################

output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.ec2_role.name
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "instance_profile_name" {
  description = "Name of the IAM Instance Profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "instance_profile_arn" {
  description = "ARN of the IAM Instance Profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}