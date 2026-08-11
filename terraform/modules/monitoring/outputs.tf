#################################################
# Monitoring Outputs
#################################################

output "high_cpu_alarm_arn" {
  description = "ARN of the EC2 high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.arn
}

output "status_check_failed_alarm_arn" {
  description = "ARN of the EC2 status check failed alarm"
  value       = aws_cloudwatch_metric_alarm.status_check_failed.arn
}