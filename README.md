# Terraform AWS Infrastructure Automation

## Overview

This repository contains Terraform configurations to automate the provisioning of AWS infrastructure components, including EC2 instances and Virtual Private Clouds (VPCs). Terraform enables Infrastructure as Code (IaC), allowing you to define and manage your infrastructure using declarative configuration files.

## What is Terraform?

Terraform is an open-source IaC tool developed by HashiCorp. It allows users to define and provision data center infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL). Terraform supports multiple cloud providers, including AWS, Azure, and Google Cloud Platform, enabling consistent and repeatable infrastructure deployment across different environments.

## Repository Structure

The repository is organized as follows:

- `main.tf` – Primary configuration file defining the desired infrastructure resources.
- `variables.tf` – Declares input variables to parameterize configurations.
- `outputs.tf` – Specifies output values to display after infrastructure deployment.
- `provider.tf` – Configures the cloud provider (e.g., AWS) and authentication details.
- `data.tf` – Defines data sources to fetch information about existing resources.
- `provisioners.tf` – Contains provisioner blocks to execute scripts on created resources.

## Prerequisites

Before using the Terraform configurations, ensure you have the following:

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed.
- An AWS account with appropriate permissions.
- AWS credentials configured locally, typically via the AWS CLI:

```bash
aws configure
```

## Terraform Components Explained

### 1. `main.tf`

The `main.tf` file is the core of the Terraform configuration. It defines the infrastructure resources to be created, such as EC2 instances, VPCs, subnets, and security groups.

```hcl
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example.id
  tags = {
    Name = "ExampleInstance"
  }
}
```

### 2. `variables.tf`

This file declares input variables, allowing customization of configurations without modifying the core files.

```hcl
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

### 3. `outputs.tf`

Defines output values to be displayed after applying the Terraform configuration.

```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

### 4. `provider.tf`

Specifies the provider configuration, including the cloud provider and region.

```hcl
provider "aws" {
  region = var.aws_region
}
```

### 5. `data.tf` (Data Sources)

Data sources allow Terraform to fetch information about existing resources.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

### 6. `provisioners.tf` (Provisioner Blocks)

Provisioners execute scripts on the local machine or on a remote resource after it's created.

```hcl
resource "aws_instance" "example" {
  # ... other configurations ...

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
```

## Creating an EC2 Instance: Step-by-Step

1. **Initialize Terraform:**

```bash
terraform init
```

2. **Review the Execution Plan:**

```bash
terraform plan
```

3. **Apply the Configuration:**

```bash
terraform apply
```

4. **Verify the Deployment:**

After the apply completes, Terraform will output the instance ID and other specified outputs.

## Creating a VPC: Step-by-Step

1. **Define the VPC:**

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MainVPC"
  }
}
```

2. **Create Subnets:**

```hcl
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "PublicSubnet"
  }
}
```

3. **Add an Internet Gateway:**

```hcl
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MainIGW"
  }
}
```

4. **Create a Route Table:**

```hcl
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}
```

5. **Associate Route Table with Subnet:**

```hcl
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

6. **Deploy the VPC:**

```bash
terraform init
terraform plan
terraform apply
```

## Best Practices

- **State Management:** Use remote backends like AWS S3 with state locking via DynamoDB.
- **Modularization:** Break down configurations into reusable modules.
- **Version Control:** Use Git to manage your configuration files.
- **Sensitive Data:** Use environment variables or secret managers for credentials.

## Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Tutorials by HashiCorp](https://developer.hashicorp.com/terraform/tutorials)
- [Creating AWS VPC Using Terraform](https://www.geeksforgeeks.org/create-aws-vpc-using-terraform/)

---

For any issues or contributions, please open an issue or submit a pull request on the [GitHub repository](https://github.com/Abhi-Wathore/terraform.git).
