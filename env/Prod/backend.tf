terraform {
  backend "s3" {
    bucket = "terraform-state-gu" #Nome do s3
    key    = "Prod/terraform.tfstate" # Local do arquivo que vamos guardar
    region = "us-west-2" #regiao
  }
}