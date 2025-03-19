output "repository_arns" {
  description = "ARNs de los repositorios ECR creados"
  value       = { for k, repo in aws_ecr_repository.repositories : k => repo.arn }
}

output "repository_urls" {
  description = "URLs de los repositorios ECR creados"
  value       = { for k, repo in aws_ecr_repository.repositories : k => repo.repository_url }
}