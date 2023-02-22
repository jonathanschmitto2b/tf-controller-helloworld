terraform {
    required_providers {
        aws = "~> 4.17"
    }
    backend "s3" {
        profile = "planktron"
        region = "us-east-1"
        bucket = "planktron-development-ias-tfstates-terraform"
        key = "infra/dev/"
    }
}

provider "aws" {
    profile = "planktron"
    region = "us-east-1"
}
resource "aws_s3_bucket" "plk-bucket-reports" {
  bucket = "plk-bucket-reports-dev"
  tags = {
    Name = "plk-bucket-reports"
    Project = "Planktron"
    Env = "dev"
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
    bucket = aws_s3_bucket.plk-bucket-reports.id
    acl = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket-public-access" {
  bucket = aws_s3_bucket.plk-bucket-reports.id
  block_public_acls = true
  block_public_policy = true
}
