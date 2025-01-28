module "Producao" {
  source = "../../infra"


  nome = "producao" 
  descricao = "Aplicação-de-producao"
  max = 5
  maquina = "t2.micro"
  ambiente = "ambiente-de-producao"
}