data "template_file" "app" {
  template = file("${path.module}/templates/task_definition.json.tpl")

  vars = {
    container_name          = local.full_name
    docker_image_url        = "${var.docker_image_url}:${var.docker_image_tag}"
    region                  = var.region
    awslogs_group           = "${local.full_name}-log-group"
    awslogs_stream_prefix   = "${local.full_name}-log-stream"
    container_port          = var.container_port
    container_cpu_units     = var.container_cpu_units
    container_mem_units     = var.container_mem_units
  }
}
