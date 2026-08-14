#################################################
# PostgreSQL Database Instance
#################################################

resource "aws_db_instance" "postgres" {

  # Database Identifier
  identifier = "${var.project_name}-${var.environment}-postgresql"

  # Engine
  engine         = "postgres"
  engine_version = "18.3"
  auto_minor_version_upgrade = true

  # Database
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # Instance
  instance_class    = var.db_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp2"
  storage_encrypted = true

  # Networking
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_security_group_id]

  publicly_accessible = false
  multi_az            = false

  # Parameter Group
  parameter_group_name = aws_db_parameter_group.this.name

  # Backup
  backup_retention_period = 1
  copy_tags_to_snapshot = true

  # Monitoring
  performance_insights_enabled = false

  # Protection
  deletion_protection = true
  skip_final_snapshot = false

  
maintenance_window = "sun:04:00-sun:05:00"

apply_immediately = true

  # Tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-postgresql"
    }
  )
}