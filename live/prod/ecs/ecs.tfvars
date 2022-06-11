#variables for ecs module
environment            = "prod"
team                   = "app"
health_check_path      = "/"
log_retention_in_days  = 30
docker_image_url       = "123456789123.dkr.ecr.us-east-1.amazonaws.com/nginx"
docker_image_tag       = "latest"
task_desired_count     = 2
container_port         = "80"
container_cpu_units    = 256
container_mem_units    = 512
ssl_certificate_arn    = "arn:aws:acm:us-east-1:123456789123:certificate/4f31f3e0-cc6e-4d7d-ad71-c7c21401bf42"
terminate_original_task_time = 5
