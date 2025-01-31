#Aqui nós colocamos as configuraçoes do bucket S3

resource "aws_s3_bucket" "beanstalk_deploys" {
  bucket = "${var.nome}-deploys"
}


resource "aws_s3_object" "docker" {
  depends_on = [ 
    aws_s3_bucket.beanstalk_deploys #Só vai rodar quando o beanstalk estiver pronto
   ]


  bucket = "${var.nome}-deploys"
  key    = "${var.nome}.zip"
  source = "${var.nome}.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.nome}.zip")
}