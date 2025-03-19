variable "repositories" {
  description = "Mapa de configuraciones básicas para los repositorios ECR"
  type = map(object({
    name = string
    tags = map(string)
  }))
}