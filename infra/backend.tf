terraform {
  # Configuracion parcial: los valores llegan por -backend-config.
  backend "s3" {
    # Bloqueo por archivo en el propio bucket. Requiere Terraform 1.10 o superior.
    use_lockfile = true
  }
}
