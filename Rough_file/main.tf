terraform {
  backend "s3" {
    bucket         = "abhi99-terraform"
    region         = "eu-north-1"
    
  }
}

resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MainVPC"
  }
  
}
resource "aws_subnet" "pub-subnet" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.pub_subnet_cidr
  map_public_ip_on_launch = true
    availability_zone = var.availability_zone
    tags = {
      Name = "PublicSubnet"
    }
}
resource "aws_subnet" "pvt-subnet" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.pvt_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "PrivateSubnet"
  }
  
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}
}

data "aws_security_group" "mysg" {
  vpc_id = aws_vpc.mainvpc.id
  filter {
    name   = "group-name"
    values = [mysg]
  }
  
}
resource "aws_instance" "web" {
  ami           = "ami-0dd574ef87b79ac6c" 
  instance_type = var.instance_type
  key_name = "new-key"
  vpc_security_group_ids = data.aws_security_group.mysg.id

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("D:/Devops/KeyPair/new-key.pem") 
    
  }
  provisioner "local-exec" {
    command = "echo this is a test"
    
  }
  provisioner "file" {
    source      = "D:/Devops/Installation of Terraform in Ubuntu.txt"
    destination = "/etc/Installation of Terraform in Ubuntu.txt"
    
  }
    provisioner "remote-exec" {
        inline = [
        "sudo yum update -y"
        ]
    }

  tags = {
    Name = "WebServer"
  }
  
}