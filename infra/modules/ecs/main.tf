resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 30
  tags = {
    Name = "${var.project_name}-ecs-log-group"
  }
}

resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-ecs-cluster"

  tags = {
    Name = "${var.project_name}-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.project_name}-task"
  container_definitions    = jsonencode([{
    name        = var.container_name,
    image       = var.container_image,
    cpu         = 256,
    memory      = 512,
    essential   = true,
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}

resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.service_sg.id]
  }

  tags = {
    Name = "${var.project_name}-service"
  }
}

#This SG is responsible to enable public access to the application-----------------------------------

resource "aws_security_group" "service_sg" {
  name        = "${var.project_name}-ecs-service-sg"
  description = "Security group for ECS project: ${var.project_name}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-ecs-service-sg"
    Project     = var.project_name
    Environment = "dev"
  }
}