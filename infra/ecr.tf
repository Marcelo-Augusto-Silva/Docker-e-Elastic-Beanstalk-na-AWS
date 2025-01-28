#Esse recuros é o repositório da AWS que funciona como o docker hub
resource "aws_ecr_repository" "repositorio" {
  name                 = var.nome
  force_delete = true
}