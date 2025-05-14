# This file contains the main configuration for the EC2_Instance module.
# It defines the provider, resources for the module.
# It also includes the backend configuration for storing the state file in S3.
# The backend configuration is used to store the Terraform state file in an S3 bucket.


terraform {
  backend "s3" {
    bucket         = var.bucket_name
    region         = var.bucket_region
    key            = var.bucket_key
  }

}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  tags = {
    Name = var.instance_name
  }
  
}