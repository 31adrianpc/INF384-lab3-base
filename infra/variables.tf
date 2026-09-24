variable "region" {
  description = "Region de AWS donde vive toda la infraestructura del laboratorio."
  type        = string
  default     = "us-east-1"
}

variable "nombre_aplicacion" {
  description = "Nombre de la aplicacion. Da nombre al repositorio de imagenes, a la funcion y al grupo de logs."
  type        = string
  default     = "inf384-lab3"
}

variable "nombre_rol_ejecucion" {
  description = "Nombre del rol de ejecucion preexistente en la cuenta academica."
  type        = string
  default     = "LabRole"
}

variable "tag_inicial" {
  description = "Tag de la imagen de marcador de posicion que permite crear la funcion por primera vez."
  type        = string
  default     = "bootstrap"
}

variable "version_aplicacion" {
  description = "Valor de APP_VERSION que la funcion devuelve en su respuesta."
  type        = string
  default     = "0.0.0-bootstrap"
}
