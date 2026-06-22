# S3 Bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
}


# Versioning
resource "aws_s3_bucket_versioning" "example_versioning" {
  bucket = aws_s3_bucket.example_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle Configuration
resource "aws_s3_bucket_lifecycle_configuration" "example_lifecycle" {
  bucket = aws_s3_bucket.example_bucket.id

  rule {
    id     = "archive-and-cleanup"
    status = "Enabled"

    filter {
      prefix = ""
    }

    # Move objects to Standard-IA after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Move objects to Glacier after 90 days
    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    # Delete objects after 365 days
    expiration {
      days = 365
    }

    # Delete old object versions after 30 days
    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
