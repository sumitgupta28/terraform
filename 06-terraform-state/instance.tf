

resource "aws_instance" "front-end-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  
  tags = {
    name ="font-end-server"
    application ="test-application"
  }
}

resource "aws_instance" "back-end-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  
  tags = {
    name ="back-end-server"
    application ="test-application"
  }
}