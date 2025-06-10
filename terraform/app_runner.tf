# App Runner サービス用のIAMロール
resource "aws_iam_role" "app_runner_service_role" {
  name = "${var.service_name}-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apprunner.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_service_role_policy" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AppRunnerServiceRolePolicy"
}

# App Runner インスタンス用のIAMロール
resource "aws_iam_role" "app_runner_instance_role" {
  name = "${var.service_name}-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      }
    ]
  })
}

# App Runner サービス
resource "aws_apprunner_service" "main" {
  service_name = var.service_name

  source_configuration {
    auto_deployments_enabled = true


    authentication_configuration {
      connection_arn = var.github_connection_arn
    }

    code_repository {
      repository_url = var.github_repository_url
      source_code_version {
        type  = "BRANCH"
        value = var.github_branch
      }
      code_configuration {
        # apprunner.yamlを参照するように設定
        configuration_source = "REPOSITORY"
      }
    }
  }

  instance_configuration {
    cpu    = "1 vCPU"
    memory = "2 GB"

    instance_role_arn = aws_iam_role.app_runner_instance_role.arn
  }

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 20
    path                = "health"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name        = var.service_name
    Environment = "production"
    ManagedBy   = "terraform"
  }
}