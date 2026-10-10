
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "telemetry" {
  bucket_prefix = "raspberry-pi-edge-telemetry-"

  tags = {
    Name        = "Raspberry Pi Edge Telemetry"
    Project     = "raspberry-pi-eks-hybrid-edge"
    Environment = "development"
  }
}

resource "aws_s3_bucket_public_access_block" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  versioning_configuration {
    status = "Enabled"
  }
}
