###############################################
# S3 Bucket for Terraform Remote State
###############################################

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_state_bucket

  tags = merge(
    local.common_tags,
    {
      Name = var.terraform_state_bucket
    }
  )
}

###############################################
# Enable Versioning
###############################################

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

###############################################
# Enable Server Side Encryption
###############################################

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

###############################################
# Block Public Access
###############################################

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

###############################################
# Enable Bucket Ownership Controls
###############################################

resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }

  lifecycle {
    prevent_destroy = true
  }
}