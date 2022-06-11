
variable "region" {
  description   = "AWS region name"
  type          = string
  default       = "us-east-1"
}

#common vars
variable "product_name" {
  description   = "Name of the product"
  type          = string
  default       = "hello-nginx"
}
variable "environment" {
  description   = "Name of the environment"
  type          = string
  default       = "prod"
}
variable "team" {
  description   = "Name of the Team"
  type          = string
  default       = "application"
}


# load balancer

variable "health_check_path" {
  description  = "Health check path for the default target group"
  type          = string
  default      = "/"
}


# logs

variable "log_retention_in_days" {
  description  = "cloudwatch log retention"
  type         = number
  default      = 30
}

# ecs

variable "docker_image_url" {
  description = "Docker image to run in the ECS cluster"
  type        = string
  default     = "nginx"
}

variable "docker_image_tag" {
  description = "Docker image tag to run in the ECS cluster"
  type        = string
  default     = "latest"
}

variable "task_desired_count" {
  description = "Number of instances of the task definition to run"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Container port"
  type        = string
  default     = "80"
}


variable "container_cpu_units" {
  description = "Container cpu units"
  type        = number
  default     = 256
}

variable "container_mem_units" {
  description = "Container memory units"
  type        = number
  default     = 512
}

variable "public_subnet_ids" {
  description = "Public Subnet ids"
  type        = list
  default     = ["subnet-04c103dbcde48b90f", "subnet-05bcabc297d5fba3e"]
}
variable "private_subnet_ids" {
  description = "Private subnet ids"
  type        = list
  default     = ["subnet-082b1996280460e8e", "subnet-08b5adc16a092db0e"]
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
  default = "vpc-07eb502196bed7fe4"
}

variable "ssl_certificate_arn" {
  description = "SSL ccertificate ARN to enable HTTPS"
  type        = string
  default     = "arn:aws:acm:us-east-1:3453446:certificate/4f31f3e0-cc6e-4d7d-ad71-c7c21401bf42"
}

variable "terminate_original_task_time" {
  description = "Wait time (in minutes) to terminate orginal task"
  type        = number
  default     = 5
}