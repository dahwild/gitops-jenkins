output "instance_ips" {
  value = ["${aws_instance.default.*.public_ip}"]
}

#Agregar definición de Output para imprimir valor del ARN para la encriptación
output "arn" {
  #El valor que contiene este Output es <tipo_recurso>.<nombre_recurso>.<campo_a_acceder> del KMS
  value = aws_kms_key.mykey.arn
}