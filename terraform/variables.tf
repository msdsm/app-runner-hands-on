variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "aws profile"
  type        = string
  default     = "msd_user"
}

variable "service_name" {
  description = "App Runner service name"
  type        = string
  default     = "fastapi-app-runner-sample"
}

variable "github_repository_url" {
  description = "GitHub repository URL"
  type        = string
  default     = "https://github.com/msdsm/app-runner-hands-on"
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
  default     = "main"
}

variable "github_connection_arn" {
  description = "GitHub connection ARN"
  type        = string
}