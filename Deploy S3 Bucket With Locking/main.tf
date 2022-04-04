#comment this block out and then deploy: 
terraform {
    backend "s3" {
        bucket = "terraform-state-csb-media"
        key = "global/s3/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-state-locking"
        encrypt = true 
    }
}


provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-csb-media"

  # Prevents from accidental deletion 
  lifecycle {
    prevent_destroy = true
  }
  #Enables versioning
  versioning {
    enabled = true
  }
  #Enables ServerSide Encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


#Performs locking for state file
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"

  }
}


#Freezes provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.2"
    }
    consul = {
      source = "hashicorp/consul"
    }
  }
  required_version = ">= 0.13"
}