#Aqui nós deixamos a configuração das roles, role é a politica de acessos
resource "aws_iam_role" "beanstalk_ec2" {
  name = "beanstalk-ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


# Define um recurso do Terraform do tipo "aws_iam_role_policy" para associar uma política IAM a um papel específico
resource "aws_iam_role_policy" "beanstalk_ec2_policy" {
  
  # Nome da política IAM que será criada e exibida no console da AWS
  name = "beanstalk-ec2-policy"
  
  # O ID do papel IAM ao qual esta política será anexada
  # Este papel é previamente definido no Terraform como "test_role"
  role = aws_iam_role.beanstalk_ec2.id 

  # Define a política IAM no formato JSON usando a função "jsonencode" do Terraform
  policy = jsonencode({
    # Especifica a versão do formato da política JSON
    Version = "2012-10-17"

    # Define as permissões concedidas pela política
    Statement = [
      {
        # Lista de ações que este papel IAM terá permissão para executar
        Action = [
          "cloudwatch:PutMetricData",          # Permite enviar métricas para o CloudWatch
          "ds:CreateComputer",                # Permite criar computadores no AWS Directory Service
          "ds:DescribeDirectories",           # Permite descrever diretórios no AWS Directory Service
          "ec2:DescribeInstanceStatus",       # Permite verificar o status de instâncias EC2
          "logs:*",                           # Permite qualquer operação nos Logs (CloudWatch Logs)
          "ssm:*",                            # Permite qualquer operação no AWS Systems Manager
          "ec2messages:*",                    # Permite qualquer operação com mensagens EC2
          "ecr:GetAuthorizationToken",        # Permite obter tokens de autorização no Elastic Container Registry (ECR)
          "ecr:BatchCheckLayerAvailability",  # Permite verificar a disponibilidade de camadas no ECR
          "ecr:GetDownloadUrlForLayer",       # Permite obter URLs de download de camadas no ECR
          "ecr:GetRepositoryPolicy",          # Permite obter políticas de repositórios no ECR
          "ecr:DescribeRepositories",         # Permite descrever repositórios no ECR
          "ecr:ListImages",                   # Permite listar imagens em repositórios no ECR
          "ecr:DescribeImages",               # Permite descrever imagens no ECR
          "ecr:BatchGetImage",                # Permite obter imagens em lote no ECR
          "s3:*"                              # Permite qualquer operação nos buckets S3
        ]

        # Define que as ações listadas acima serão permitidas
        Effect   = "Allow"

        # Permite que as ações sejam realizadas em todos os recursos
        Resource = "*"
      },
    ]
  })
}

# Aqui nós criamos o perfil que vamos 
resource "aws_iam_instance_profile" "beanstalk_ec2_profile" {
  name = "beanstalk-ec2-profile"
  role = aws_iam_role.beanstalk_ec2.name
}
