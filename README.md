# Docker e Elastic Beanstalk na AWS
 
O ambiente de homologação serve para ver se tem algum bug ou algo do tipo, é um ambiente de testes


Nos criamos um bucket s3 na amazon para armazenar os arquivos de statement do terraform

o s3 funciona como uma pasta compartilhada onde voce pode guardar os arquivos


O beanstalk serve para automatizar a infra, ele aloca maquinas automaticamente e tambem gerencia a infra, ele é um PAAS



comando para conectar o docker na conta = aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 637423334565.dkr.ecr.us-west-2.amazonaws.com





docker build -t producao:v1 .

docker tag c0d1161b2daf 637423334565.dkr.ecr.us-west-2.amazonaws.com/producao:v1


comando para zipar arquivos = zip -r producao.zip Dockerrun.aws.json

 docker push 637423334565.dkr.ecr.us-west-2.amazonaws.com/producao:v1


comando para atualizar o ambiente no beanstalk = gu@DESKTOP-RK236QA:/mnt/c/Users/Gu/Documents/GitHub/Docker-e-Elastic-Beanstalk-na-AWS/env/Prod$ aws elasticbeanstalk update-environment --environment-name ambiente-de-producao --version-label ambiente-de-producao


Quando formos atualizar o beanstalk precisamos mandar a imagem do docker para o ecr se nao ele nao vai conseguir atualizar 


aws ecr list-images --repository-name producao --region us-west-2 
