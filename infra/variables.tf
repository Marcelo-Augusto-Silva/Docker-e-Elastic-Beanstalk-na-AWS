variable "nome" {
  type = string
  description = "essa variavel serve para definir o nome do repositorio"
}

variable "descricao" {
  type = string
  description = "Variavel usada para descrição"
}

variable "max" {
  type = number
  description = "Numero maximo de maquinas que vai ser utilizado no beanstalk"
}

variable "maquina" {
  type = string
  description = "tipo de maquina que vamos utilizar"
  
}

variable "ambiente" {
  type = string
  description = "variavel que define o nome do ambiente"
}