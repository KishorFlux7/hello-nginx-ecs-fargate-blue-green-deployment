[
  {
    "name": "${container_name}",
    "image": "${docker_image_url}",
    "essential": true,
    "cpu": ${container_cpu_units},
    "memory": ${container_mem_units},
    "links": [],
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port},
        "protocol": "tcp"
      }
    ],
    "environment": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${awslogs_stream_prefix}"
      }
    }
  }
]
