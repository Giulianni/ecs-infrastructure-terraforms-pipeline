output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution.arn
  description = "ARN of the ECS task execution role"
}

output "ecs_task_role_arn" {
  value       = aws_iam_role.ecs_task_role.arn
  description = "ARN of the ECS task role"
}

output "ecs_logs_policy_arn" {
  value = aws_iam_policy.ecs_logs_policy.arn
  description = "ARN of the policy that allows ECS tasks to write logs to CloudWatch"
}