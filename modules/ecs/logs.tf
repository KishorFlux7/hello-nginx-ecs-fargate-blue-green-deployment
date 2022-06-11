resource "aws_cloudwatch_log_group" "app-log-group" {
  name              = "${local.full_name}-log-group"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "app-log-stream" {
  name           = "${local.full_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.app-log-group.name
}
