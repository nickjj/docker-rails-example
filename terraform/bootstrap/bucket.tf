resource "aws_s3_bucket" "terraform_tfstate" {
  bucket = "grupo-5-terraform"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_tfstate.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [ aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership ]

  bucket = aws_s3_bucket.terraform_tfstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.terraform_tfstate.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_enc" {
  bucket = aws_s3_bucket.terraform_tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_tfstate" {
  bucket = aws_s3_bucket.terraform_tfstate.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}