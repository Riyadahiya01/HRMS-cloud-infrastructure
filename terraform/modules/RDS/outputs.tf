output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.postgres.id
}

output "db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.postgres.arn
}

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "db_port" {
  description = "RDS Port"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.postgres.db_name
}