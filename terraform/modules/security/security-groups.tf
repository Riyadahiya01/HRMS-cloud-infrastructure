locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

#################################################
# Application Load Balancer Security Group
#################################################

resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

lifecycle {
  prevent_destroy = true
}

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-alb-sg"
    }
  )
}

#################################################
# EC2 Security Group
#################################################

resource "aws_security_group" "ec2" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "Security Group for EC2 Instance"
  vpc_id      = var.vpc_id

lifecycle {
  prevent_destroy = true
}

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-ec2-sg"
    }
  )
}

#################################################
# RDS Security Group
#################################################

resource "aws_security_group" "rds" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Security Group for PostgreSQL Database"
  vpc_id      = var.vpc_id

lifecycle {
  prevent_destroy = true
}

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-rds-sg"
    }
  )
}






########################################
# Internet -> ALB (HTTPS)
########################################

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow HTTPS traffic from Internet"
}







########################################
# ALB -> EC2 (HTTP)
########################################

resource "aws_vpc_security_group_ingress_rule" "ec2_http" {
  security_group_id = aws_security_group.ec2.id

  referenced_security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  description = "Allow HTTP traffic from ALB"
}


########################################
# Internet -> EC2 (HTTP)
########################################

resource "aws_vpc_security_group_ingress_rule" "ec2_http_public" {
  security_group_id = aws_security_group.ec2.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"

  description = "Temporary HTTP access"
}




########################################
# EC2 -> RDS (PostgreSQL)
########################################

resource "aws_vpc_security_group_ingress_rule" "rds_postgres" {
  security_group_id = aws_security_group.rds.id

  referenced_security_group_id = aws_security_group.ec2.id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432

  description = "Allow PostgreSQL traffic from EC2"
}



########################################
# EC2 -> Internet (All Outbound)
########################################

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {

  security_group_id = aws_security_group.ec2.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}



########################################
# RDS -> Outbound
########################################

resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {

  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow outbound traffic"
}





########################################
# ALB -> Outbound
########################################

resource "aws_vpc_security_group_egress_rule" "alb_all_outbound" {

  security_group_id = aws_security_group.alb.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow outbound traffic"
}