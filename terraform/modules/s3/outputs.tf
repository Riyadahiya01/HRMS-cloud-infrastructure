########################################
# S3 Bucket Outputs
########################################

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.employee_documents.id
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.employee_documents.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.employee_documents.arn
}