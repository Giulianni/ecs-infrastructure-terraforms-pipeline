output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.main.arn
  description = "The ARN of the ECS task definition"
}

//output "ecs_service_name" {
//  value = aws_ecs_service.main.name
//}