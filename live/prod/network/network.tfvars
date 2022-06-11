#variables for network module
vpc_cidr               = "10.0.0.0/16"
environment            = "prod"
team                   = "infra"
public_subnets_cidr    = ["10.0.0.0/23", "10.0.2.0/23"]
private_subnets_cidr   = ["10.0.4.0/23", "10.0.6.0/23"]
availability_zones     = ["us-east-1a", "us-east-1b"]
