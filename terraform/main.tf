provider "aws" {}

# Creación de una instancia
resource "aws_instance" "web" {
   connection {
    user = "ubuntu"
    key_file = "key_jdmr"
  }
  subnet_id = "subnet-0a8ecb51"
  instance_type = "t2.micro"
  ami = "ami-04b9e92b5572fa0d1"
  key_name = "key_jdmr"
  tags ={
    Name = "prueba"
  }
}