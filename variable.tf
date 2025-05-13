variable "instance_type" {
  description = "Type of instance to create"
  default     = "t3.micro"
  
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default     = "10.0.0/16"
  
}
variable "pub_subnet_cidr" {
    description = "CIDR block for the subnet"
    default     = "10.0.0/24"
  
}
variable "pvt_subnet_cidr" {
    description = "CIDR block for the subnet"
    default     = "10.0.1/24"
  
}
variable "availability_zone" {
    description = "Availability zone for the subnet"
    default     = "eu-north-1a"
  
}