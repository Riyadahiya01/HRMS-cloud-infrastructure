output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = values(aws_subnet.public)[*].id
}

output "private_app_subnet_ids" {
  description = "Private App Subnet IDs"
  value       = values(aws_subnet.private_app)[*].id
}

output "private_db_subnet_ids" {
  description = "Private Database Subnet IDs"
  value       = values(aws_subnet.private_db)[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}