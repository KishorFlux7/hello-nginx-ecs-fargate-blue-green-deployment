variable "region" {
  description = "AWS Deployment region.."
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for vpc to create.."
  type = string
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "Set environment.."
  type = string
  default = "prod"
}

variable "team" {
  description = "Set team.."
  type = string
  default = "infra"
}

variable "product_name" {
  description = "Set application name.."
  type = string
  default = "hello-nginx"
}

variable "public_subnets_cidr" {
  description = "Public subnet CIDR.."
  type = list
  default = ["10.0.0.0/23", "10.0.2.0/23"]
}

variable "private_subnets_cidr" {
  description = "Private subnet CIDR.."
  type = list
  default = ["10.0.4.0/23", "10.0.6.0/23"]
}

variable "availability_zones" {
  description = "availability zones.."
  type = list
  default = ["us-east-1a", "us-east-1b"]
}
