# Use AWS Terraform provider
provider "aws" {
  region = "us-east-2"
}

# Se agrega recurso KMS para encriptar la información en el Bucket
resource "aws_kms_key" "mykey" {
  description             = "key state file"
  # dias de rotacion de las llaves
  deletion_window_in_days = 10
}
# Creacion del Bucket
resource "aws_s3_bucket" "dahwild-backend" {
    bucket = var.bucket_name
    force_destroy = true
    # Estos son los tipos de permisos que va a tener el bucket
    acl = var.acl
    tags = var.tags
    # Se crea definición del Bucket para realizar encriptación agregando la Key KMS
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
   }
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  user_data = file("user-data.txt") 
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ingress {
   # from_port   = 22
   # to_port     = 22
   # protocol    = "tcp"
   # cidr_blocks = ["0.0.0.0/0"]
  #}

}
