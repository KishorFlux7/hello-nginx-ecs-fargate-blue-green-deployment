# hello-nginx-ecs-fargate-blue-green-deployment
Use this repository to deploy nginx docker container using ECS Fargate. Do blue-green deployment using AWS CodeDeploy.

# Repository Structure
Following is the repository structure -
```
.
├── common.tfvars
├── live
│   └── prod
│       ├── ecs
│       └── network
├── modules
│   ├── ecs
│   │   ├── alb.tf
│   │   ├── blue-green.tf
│   │   ├── data.tf
│   │   ├── iam.tf
│   │   ├── logs.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── sg.tf
│   │   ├── templates
│   │   └── variables.tf
│   └── network
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── README.md
└── terragrunt.hcl
```
- **common.tfvars** -
Contains common terraform vars used in all modules.
- **live/prod** -
Terragrunt settings specific to prod environment.
- **live/prod/ecs** -
Terragrunt settings specific to prod environment ECS module.
- **live/prod/network** -
Terragrunt settings specific to prod environment network module.
- **modules/ecs** -
Terraform ecs module. This module creates ECS-Fargate, ALB and CodeDeploy etc AWS resources.
- **modules/network** -
Terraform ecs module. This module creates VPC, Subnets, NAT Gateway and Internet Gateway etc AWS resources.
- **README.md** -
This README.md file.
- **terragrunt.hcl** -
Root level terragrunt settings file. It defines AWS provider and S3 backend for terraform.


# Inputs
Varibles inputs explained below -
| Name  | Description | Type  | Default | Required |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| region  | AWS Deployment region  | string  | us-east-1  | yes  |
| vpc_cidr  | CIDR for vpc to create  | string  | 10.0.0.0/16  | yes  |
| environment  | Set environment  | string  | prod  | yes  |
| team  | Set team  | string  | infra/app  | yes  |
| product_name  | Set application name  | string  | hello-nginx  | yes  |
| public_subnets_cidr  | Public subnet CIDR  | list  | ["10.0.0.0/23", "10.0.2.0/23"]  | yes  |
| private_subnets_cidr  | Private subnet CIDR  | list  | ["10.0.4.0/23", "10.0.6.0/23"]  | yes  |
| availability_zones  | availability zones  | list  | ["us-east-1a", "us-east-1b"]  | yes  |
| health_check_path  | Health check path for the default target group  | string  | "/"  | yes  |
| log_retention_in_days  | cloudwatch log retention  | number  | 30  | yes  |
| docker_image_url  | Docker image to run in the ECS cluster  | string  | nginx  | yes  |
| docker_image_tag  | Docker image tag to run in the ECS cluster  | string  | latest  | yes  |
| task_desired_count  | Number of instances of the task definition to run  | number  | 2  | yes  |
| container_port  | Container port  | string  | "80"  | yes  |
| container_cpu_units  | Container cpu units  | number  | 256  | yes  |
| container_mem_units  | Container memory units  | number  | 512  | yes  |
| public_subnet_ids  | Public Subnet ids  | list  | ["subnet-04c103dbcde48b90f", "subnet-05bcabc297d5fba3e"]  | no  |
| private_subnet_ids  | Private subnet ids  | list  | ["subnet-082b1996280460e8e", "subnet-08b5adc16a092db0e"]  | no  |
| vpc_id  | SSL ccertificate ARN to enable HTTPS  | string  | arn:aws:acm:us-east-1:3453446:certificate/4f31f3e0-cc6e-4d7d-ad71-c7c21401bf42  | yes  |
| ssl_certificate_arn  | Set team  | string  | infra/app  | yes  |
| terminate_original_task_time  | Wait time (in minutes) to terminate orginal task  | number  | 5  | yes  |




# Prerequisite
- Following tools required to be installed and running/available -

| Tool Name  | Tested on Version |
| ------------- | ------------- |
| Terraform  | v1.1.9  |
| Terragrunt  |  v0.37.3 |


- Need [AWS CLI Access](https://terragrunt.gruntwork.io/docs/features/work-with-multiple-aws-accounts/) and permission
- Internet access

# How to run
Use following steps to create the infrastructure -
1. Install all modules in single command -
You can create complete infrastructure using single command.
     - Clone this repository
     - Run following command and enter `y` on `(y/n)` prompt -

        `terragrunt run-all apply`

     - Sample expected Output. Open the actual shown URL on your terminal into the web-browser
     ```
      $terragrunt run-all apply        
      INFO[0000] The stack at /hello-nginx-ecs-fargate-blue-green-deployment will be processed in the following order for command apply:
      Group 1
      - Module /hello-nginx-ecs-fargate-blue-green-deployment/live/prod/network

      Group 2
      - Module /hello-nginx-ecs-fargate-blue-green-deployment/live/prod/ecs
      
      Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) y
      Acquiring state lock. This may take a few moments...
      .
      .
      .
      .
      Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

      Outputs:

      alb_hostname = "prod-app-hello-nginx-alb-45267.us-east-1.elb.amazonaws.com"
     ```
      You should be able to access website using URK `prod-app-hello-nginx-alb-457236267.us-east-1.elb.amazonaws.com`
2. Delete all modules in single command - 
You can destroy complete infrastructure using single command.
     - Make sure you have the correct vars
     - Run following command and enter `y` on `(y/n)` prompt -

        `terragrunt run-all destroy`

     - Sample expected Output. 
     ```
     $terragrunt run-all destroy
      INFO[0000] The stack at /hello-nginx-ecs-fargate-blue-green-deployment will be processed in the following order for command destroy:
      Group 1
      - Module /hello-nginx-ecs-fargate-blue-green-deployment/live/prod/ecs

      Group 2
      - Module /hello-nginx-ecs-fargate-blue-green-deployment/live/prod/network
      
      WARNING: Are you sure you want to run `terragrunt destroy` in each folder of the stack described above? There is no undo! (y/n) y
      Acquiring state lock. This may take a few moments...
      .
      .
      .
      .
      .
      aws_vpc.vpc: Destruction complete after 1s
      Releasing state lock. This may take a few moments...

      Destroy complete! Resources: 17 destroyed.
     ```
