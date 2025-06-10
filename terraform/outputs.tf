output "app_runner_service_url" {
  description = "App Runner service URL"
  value       = "https://${aws_apprunner_service.main.service_url}"
}

output "app_runner_service_arn" {
  description = "App Runner service ARN"
  value       = aws_apprunner_service.main.arn
}

output "app_runner_service_id" {
  description = "App Runner service ID"
  value       = aws_apprunner_service.main.service_id
}

output "app_runner_service_status" {
  description = "App Runner service status"
  value       = aws_apprunner_service.main.status
}