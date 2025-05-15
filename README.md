# Terraform AWS Infrastructure Automation

This repository contains modular Terraform configurations designed to provision AWS infrastructure components, including Virtual Private Clouds (VPCs) and EC2 instances.

# What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp that allows users to define and provision data center infrastructure using a declarative configuration language. It enables infrastructure automation across multiple service providers, including AWS, Azure, Google Cloud, and many others.


## Advantages of Terraform

- 🚀 Automation: Automates infrastructure provisioning, scaling, and configuration.
- 🔄 Repeatability: Code-based infrastructure ensures repeatable and consistent deployments.
- ☁️ Multi-cloud Support: Works across multiple providers like AWS, Azure, GCP, and on-premises systems.
- 📖 Version Control: Infrastructure changes can be tracked using Git or other version control systems.
- 🛠️ Modularization: Reuse components using modules to manage infrastructure efficiently.
- 🔍 Preview Changes: See proposed changes before applying with `terraform plan`.
- 💥 State Management: Keeps track of real-time infrastructure via a state file, enabling efficient updates.



## 📚 Table of Contents

- [Overview](#overview)
- [Prerequisites](#Prerequisites)
- [Module Structure](#module-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)
  - [VPC Module](#vpc-module)
  - [EC2 Instance Module](#ec2-instance-module)
- [Variables](#variables)
- [Outputs](#outputs)
- [Provisioning Steps](#provisioning-steps)
- [Destroying Infrastructure](#destroying-infrastructure)
- [Best Practices](#best-practices)

## 📖 Overview

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It enables users to define and provision infrastructure using a declarative configuration language. This repository leverages Terraform to automate the deployment of AWS resources, promoting consistency and scalability in infrastructure management.

## ✅ Prerequisites

Before utilizing this repository, ensure you have the following installed and configured:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0 or higher)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- An AWS account with appropriate permissions
- Configured AWS credentials (`~/.aws/credentials`)

## 📁 Module Structure

The repository is organized into modular components for reusability and clarity:

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── EC2_Instance/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── VPC/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

## 🚀 Getting Started

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Abhi-Wathore/terraform.git
   cd terraform
   ```

2. **Initialize Terraform**:

   ```bash
   terraform init
   ```

3. **Review and Customize Variables**:

   Edit the `variables.tf` files in the root and module directories to customize the infrastructure parameters as needed.

4. **Plan the Deployment**:

   ```bash
   terraform plan
   ```

5. **Apply the Configuration**:

   ```bash
   terraform apply
   ```

## 🧱 Usage

### VPC Module

The VPC module provisions a Virtual Private Cloud with public and private subnets, an internet gateway, and route tables.

**Example Configuration**:

```hcl
module "vpc" {
  source               = "./VPC"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  pub_subnet_cidr      = var.pub_subnet_cidr
  pvt_subnet_cidr      = var.pvt_subnet_cidr
  availability_zone    = var.availability_zone
  route_cidr           = var.route_cidr
  filter_name          = var.filter_name
  security_group_name  = var.security_group_name
  pub_subnet_name      = var.pub_subnet_name
  pvt_subnet_name      = var.pvt_subnet_name
}
```

### EC2 Instance Module

The EC2_Instance module launches an EC2 instance within the specified VPC and subnet, with configurations for AMI, instance type, and key pair.

**Example Configuration**:

```hcl
module "instances" {
  source         = "./EC2_Instance"
  instance_name  = var.instance_name
  ami            = var.ami
  instance_type  = var.instance_type
  key_name       = var.key_name
  bucket_name    = var.bucket_name
  bucket_key     = var.bucket_key
  bucket_region  = var.bucket_region
  aws_region     = var.aws_region
}
```

## 🔧 Variables

Key variables utilized across modules include:

- **vpc_name**: Name of the VPC.
- **vpc_cidr**: CIDR block for the VPC (e.g., "10.0.0.0/16").
- **pub_subnet_cidr**: CIDR block for the public subnet (e.g., "10.0.1.0/24").
- **pvt_subnet_cidr**: CIDR block for the private subnet (e.g., "10.0.2.0/24").
- **availability_zone**: AWS availability zone (e.g., "eu-north-1a").
- **route_cidr**: CIDR block for route table (e.g., "0.0.0.0/0").
- **filter_name**: Name filter for security group lookup.
- **security_group_name**: Name of the security group.
- **pub_subnet_name**: Name tag for the public subnet.
- **pvt_subnet_name**: Name tag for the private subnet.
- **instance_name**: Name tag for the EC2 instance.
- **ami**: AMI ID for the EC2 instance.
- **instance_type**: EC2 instance type (e.g., "t2.micro").
- **key_name**: Name of the SSH key pair.
- **bucket_name**: Name of the S3 bucket for backend state.
- **bucket_key**: Key path within the S3 bucket for the state file.
- **bucket_region**: AWS region where the S3 bucket is located.
- **aws_region**: AWS region for resource deployment.

## 📤 Outputs

The modules expose several outputs to provide information about the created resources:

- **vpc_id**: ID of the created VPC.
- **public_subnet_ids**: IDs of the public subnets.
- **private_subnet_ids**: IDs of the private subnets.
- **instance_id**: ID of the EC2 instance.
- **instance_public_ip**: Public IP address of the EC2 instance.

## 🛠️ Provisioning Steps

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Validate Configuration**:

   ```bash
   terraform validate
   ```

3. **Plan Infrastructure Changes**:

   ```bash
   terraform plan
   ```

4. **Apply Configuration**:

   ```bash
   terraform apply
   ```

## 🧹 Destroying Infrastructure

To tear down all resources managed by this Terraform configuration:

```bash
terraform destroy
```

Confirm the prompt to proceed with the destruction of resources.

## 📝 Best Practices

- **State Management**: Utilize remote state storage (e.g., S3 with DynamoDB locking) for collaborative environments.
- **Variable Management**: Keep sensitive variables (e.g., AWS credentials) secure and avoid hardcoding them.
- **Modularization**: Encapsulate reusable configurations into modules for better maintainability.
- **Version Control**: Pin provider and module versions to prevent unexpected changes.
- **Documentation**: Maintain up-to-date documentation for each module, including input/output variables and usage examples.
