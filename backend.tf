#Configurando el Bucket como Backend
terraform {
  backend "s3" {
    #nombre del Bucket
    bucket = "backend-terraform-dahwild"
    # Key donde vamos a guardar el estado, el ambiente de trabajo
    key    = "dev"
    region = "us-east-2"
    #Agregar encriptacion
    encrypt = true
    # Enviar ARN del recurso de la llave que creó al archivo de estado
    # kms_key_id = "arn:aws:kms:us-east-2:511857092531:key/b2660417-bae3-408b-b42a-0cd811afd7f8"
    # Este argumento se añade para poder en un futuro eliminar el Bucket.    
  }
}