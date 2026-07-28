########################################
# IAM Role
########################################

resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-role"
    }
  )
}





########################################
# IAM Policy
########################################

resource "aws_iam_policy" "s3_access" {
  name        = "${var.project_name}-${var.environment}-s3-access-policy"
  description = "Allow EC2 to access the HRMS S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowBucketListing"
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = var.bucket_arn
      },
      {
        Sid    = "AllowObjectOperations"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "${var.bucket_arn}/*"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-s3-access-policy"
    }
  )
}





########################################
# Attach Policy to IAM Role
########################################

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}





########################################
# IAM Instance Profile
########################################

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-${var.environment}-ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-profile"
    }
  )
}