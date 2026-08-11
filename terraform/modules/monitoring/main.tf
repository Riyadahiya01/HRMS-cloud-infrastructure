#################################################
# CloudWatch Monitoring - EC2
#################################################

# EC2 High CPU Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name        = "${var.project_name}-${var.environment}-ec2-high-cpu"
  alarm_description = "Monitors CPU utilization of the HRMS development EC2 application server. Alarm enters ALARM state when average CPU utilization exceeds 70% for 1 datapoint within 5 minutes."

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  period    = 300
  statistic = "Average"

  threshold         = 70
  treat_missing_data = "notBreaching"

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-high-cpu"
    }
  )
}


# EC2 Status Check Failed Alarm
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name        = "${var.project_name}-${var.environment}-ec2-status-check-failed"
  alarm_description = "EC2 status check failure"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  metric_name = "StatusCheckFailed"
  namespace   = "AWS/EC2"

  period    = 300
  statistic = "Average"

  threshold         = 1
  treat_missing_data = "notBreaching"

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-status-check-failed"
    }
  )
}