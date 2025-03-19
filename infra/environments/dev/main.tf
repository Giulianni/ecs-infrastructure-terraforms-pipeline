module "networking" {
  source         = "../../modules/networking"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  project_name   = "demo-project"
}

module "ecs" {
  source             = "../../modules/ecs"
  project_name       = "demo-project"
  container_name     = "demo-container"
  container_image    = var.container_image
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  subnets            = module.networking.public_subnets
  aws_region         = "us-east-1"
  vpc_id             = module.networking.vpc_id

}

module "iam" {
  source       = "../../modules/iam"
  project_name = "demo-project"
  aws_region         = "us-east-1"
}

module "ecr" {
  source = "../../modules/ecr"

  repositories = {
    demo_repo = {
      name = "demo-repository"
      tags = {
        Environment = "dev"
        Project     = "demo-project"
      }
    }
  }
}

output "ecr_repository_urls" {
  description = "URLs de los repositorios ECR creados"
  value       = module.ecr.repository_urls
}