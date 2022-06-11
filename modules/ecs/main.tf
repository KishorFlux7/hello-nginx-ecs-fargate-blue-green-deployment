locals {
  prefix           = "${var.environment}-${var.team}"
  full_name        = "${local.prefix}-${var.product_name}"
}
resource "aws_ecs_cluster" "production" {
  name = "${local.full_name}-cluster"
}



resource "aws_ecs_task_definition" "app" {
  family                      = "${local.full_name}-task-def"
  network_mode                = "awsvpc"
  requires_compatibilities    = ["FARGATE"]
  cpu                         = var.container_cpu_units
  memory                      = var.container_mem_units
  container_definitions       = data.template_file.app.rendered
  execution_role_arn          = aws_iam_role.ecs_task_execution_role.arn
#  task_role_arn               = aws_iam_role.ecs_task_role.arn
  
}

resource "aws_ecs_service" "production" {
  name                    = "${local.full_name}-service"
  cluster                 = aws_ecs_cluster.production.id
  task_definition         = aws_ecs_task_definition.app.arn

  desired_count           = var.task_desired_count

  launch_type             = "FARGATE"
  scheduling_strategy     = "REPLICA"

  load_balancer {
    target_group_arn      = aws_alb_target_group.blue-target-group.arn
    container_name        = local.full_name
    container_port        = var.container_port
  }
  network_configuration {
    assign_public_ip      = false
    subnets               = var.private_subnet_ids
    security_groups       = [aws_security_group.ecs.id]
  }
  deployment_controller {
    type                  = "CODE_DEPLOY"
  }
}
