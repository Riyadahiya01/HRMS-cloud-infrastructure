locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

#################################################
# Amazon S3 Bucket
#################################################

resource "aws_s3_bucket" "employee_documents" {
  bucket = var.bucket_name

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-employee-documents"
    }
  )
}




########################################
# Bucket Ownership Controls
########################################

resource "aws_s3_bucket_ownership_controls" "employee_documents" {
  bucket = aws_s3_bucket.employee_documents.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}





########################################
# Block Public Access
########################################

resource "aws_s3_bucket_public_access_block" "employee_documents" {
  bucket = aws_s3_bucket.employee_documents.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket_ownership_controls.employee_documents
  ]
}





########################################
# Bucket Versioning
########################################

resource "aws_s3_bucket_versioning" "employee_documents" {
  bucket = aws_s3_bucket.employee_documents.id

  versioning_configuration {
    status = "Enabled"
  }
}





#################################################
# S3 Bucket Server-Side Encryption
#################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "employee_documents" {
  bucket = aws_s3_bucket.employee_documents.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}













