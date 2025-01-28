module "Homologacao" {
  source = "../../Infra"


  nome = "homologacao" 
  descricao = "Aplicação-de-homologacao"
  max = 3
  maquina = "t2.micro"
  ambiente = "ambiente-de-homologacao"
}