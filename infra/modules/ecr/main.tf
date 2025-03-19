resource "aws_ecr_repository" "repositories" {
  for_each = var.repositories

  name                 = each.value.name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = each.value.tags
}