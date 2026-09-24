output "url_repositorio" {
  description = "URL del repositorio de imagenes, sin tag. El repositorio lo crea setup-infra."
  value       = local.url_repositorio
}

output "imagen_inicial" {
  description = "Imagen de marcador de posicion con la que nace la funcion."
  value       = local.imagen_inicial
}

output "nombre_funcion" {
  description = "Nombre de la funcion Lambda."
  value       = aws_lambda_function.app.function_name
}

output "arn_funcion" {
  description = "ARN de la funcion Lambda."
  value       = aws_lambda_function.app.arn
}

output "grupo_de_logs" {
  description = "Nombre del grupo de logs de la funcion."
  value       = aws_cloudwatch_log_group.funcion.name
}
