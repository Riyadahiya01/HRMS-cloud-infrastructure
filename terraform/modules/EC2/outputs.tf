#################################################
# EC2 Outputs
#################################################

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.app_server.id
}

output "instance_arn" {
  description = "EC2 Instance ARN"
  value       = aws_instance.app_server.arn
}

output "private_ip" {
  description = "Private IP Address"
  value       = aws_instance.app_server.private_ip
}

output "private_dns" {
  description = "Private DNS Name"
  value       = aws_instance.app_server.private_dns
}

output "availability_zone" {
  description = "Availability Zone"
  value       = aws_instance.app_server.availability_zone
}