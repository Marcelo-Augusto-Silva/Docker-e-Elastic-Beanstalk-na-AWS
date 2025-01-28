# Tudo o que formos fazer no beanstalk iremos colocar nesse arquivo

#Aqui nós criamos nosso beanstalk
resource "aws_elastic_beanstalk_application" "aplicacao_beanstalk" {
  name        = var.nome
  description = var.descricao
}

#Aqui nós criamos nosso ambiente
resource "aws_elastic_beanstalk_environment" "ambiente_beanstalk" {
  name                = var.ambiente
  application         = aws_elastic_beanstalk_application.aplicacao_beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.4.2 running Docker" #Aqui nós colocamos um ambiente docker 

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.maquina #tipo de maquina que irá usar
  }


  #Aqui nós colocamos o valor maximo se maquinas o autoscaling
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize" 
    value     = var.max
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile" # O perfil que será utilizado
    value     = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [ 
    aws_elastic_beanstalk_environment.ambiente_beanstalk,
    aws_elastic_beanstalk_application.aplicacao_beanstalk,
    aws_s3_object.docker
   ]


  name        = var.ambiente
  application = var.nome
  description = var.descricao
  bucket      = aws_s3_bucket.beanstalk_deploys.id #Aqui nós colocamos o id do beanstalk 
  key         = aws_s3_object.docker.id #Aqui nós colocamos o ID do objeto 
}