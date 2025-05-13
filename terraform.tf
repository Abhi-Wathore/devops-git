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
  instance_type = "t3.micro"
  key_name = "new-key"

  tags = {
    Name = "WebServer"
  }
  
}