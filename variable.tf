variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
    default     = "my-vpc"
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "pub_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type        = string
    default     = "10.0.1.0/24"
}

variable "pvt_subnet_cidr" {
    description = "CIDR block for the private subnet"
    type        = string
    default     = "10.0.2.0/24"
}

variable "availability_zone" {
    description = "Availability zone for the subnets"
    type        = string
    default     = "eu-north-1a"
}

variable "route_cidr" {
    description = "CIDR block for the route table"
    type        = string
    default     = "0.0.0.0.0/0"
}

variable "filter_name" {
    description = "Name of the security group filter"
    type        = string
    default     = "group_name"
}

variable "security_group_name" {
    description = "Name of the security group"
    type        = string
    default     = "my-security-group"
}

variable "pub_subnet_name" {
    description = "Name of the public subnet"
    type        = string
    default     = "public-subnet"
}

variable "pvt_subnet_name" {
    description = "Name of the private subnet"
    type        = string
    default     = "private-subnet"
}

variable "aws_region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "eu-north-1"
}

variable "instance_name" {
    description = "Name of the EC2 instance"
    type        = string
    default     = "my-instance"
}

variable "instance_type" {
    description = "Type of the EC2 instance"
    type        = string
    default     = "t3.micro"
}

variable "key_name" {
    description = "Name of the key pair for SSH access"
    type        = string
    default     = "new-key"
}

variable "ami" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = "ami-0c1ac8a41498c1a9c" # Example AMI ID, replace with a valid one
}

variable "bucket_name" {
    description = "Name of the S3 bucket"
    type        = string
    default     = "my1-2unique-3bucket-4name" # Ensure this is globally unique
}

variable "bucket_region" {
    description = "Region for the S3 bucket"
    type        = string
    default     = "eu-north-1"
}

variable "bucket_key" {
    description = "Key for the S3 bucket object"
    type        = string
    default     = "my-object-key"
}