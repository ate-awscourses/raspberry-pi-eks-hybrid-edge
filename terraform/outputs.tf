output "telemetry_bucket_name" {
  description = "S3 bucket for Raspberry Pi telemetry"
  value       = aws_s3_bucket.telemetry.bucket
}

output "telemetry_bucket_arn" {
  description = "ARN of the telemetry S3 bucket"
  value       = aws_s3_bucket.telemetry.arn
}

