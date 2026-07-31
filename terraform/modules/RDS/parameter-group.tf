#################################################
# PostgreSQL Parameter Group
#################################################

resource "aws_db_parameter_group" "this" {
  name        = "${var.project_name}-${var.environment}-postgres-parameter-group"
 family = "postgres18"
  description = "PostgreSQL parameter group for ${var.project_name}-${var.environment}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-postgres-parameter-group"
    }
  )
}