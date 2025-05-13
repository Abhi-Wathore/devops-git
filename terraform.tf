terraform {
  backend "s3" {
    bucket         = "abhi99-terraform"
    region         = "eu-north-1"
    
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0dd574ef87b79ac6c" 
  instance_type = var.instance_type
  key_name = "new-key"

  tags = {
    Name = "WebServer"
  }
  
}

variable "instance_type" {
  description = "Type of instance to create"
  default     = "t3.micro"
  
}