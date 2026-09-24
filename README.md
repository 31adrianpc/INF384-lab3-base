# inf384-lab3

Funcion AWS Lambda empaquetada como imagen de contenedor, con su infraestructura
en Terraform y dos pipelines de GitHub Actions.

Este es el repositorio base del Laboratorio 3. Los bloques marcados con `# TODO`
estan sin resolver: completarlos es el laboratorio.

## Requisitos

Node 20, Docker y Terraform 1.10 o superior.

## Pruebas en local

```bash
npm ci
npm test
npm run test:coverage   # deja el reporte en coverage/
```

## Imagen en local

```bash
docker build --platform linux/amd64 -t inf384-lab3 .
docker run --rm -p 9000:8080 inf384-lab3
```

En otra terminal:

```bash
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

Para iterar sobre el Dockerfile sin esperar al pipeline completo esta el
workflow `construir-imagen`: construye, reporta el tamano de cada etapa y corre
las dos comprobaciones del criterio de aceptacion. No publica nada.

## Empaquetado en local

```bash
npm run build    # deja el artefacto en dist/handler.js
```

## Configuracion del repositorio

Sin estos valores los pipelines no corren. Se cargan en
`Settings > Secrets and variables > Actions`.

| Valor | Tipo | De donde sale |
|---|---|---|
| `AWS_ACCESS_KEY_ID` | Secret | Sesion del entorno academico. Caduca |
| `AWS_SECRET_ACCESS_KEY` | Secret | Sesion del entorno academico. Caduca |
| `AWS_SESSION_TOKEN` | Secret | Sesion del entorno academico. Caduca |
| `SONAR_TOKEN` | Secret | SonarQube Cloud |
| `SONAR_ORG` | Variable | SonarQube Cloud |
| `SONAR_PROJECT_KEY` | Variable | SonarQube Cloud |

El proyecto en SonarQube Cloud se crea **importando este repositorio** desde
GitHub, no manualmente, igual que en el Laboratorio 2. Es un proyecto nuevo:
el del Laboratorio 2 corresponde a otro repositorio y no sirve. La project key
que SonarQube Cloud genera se copia tal cual en `SONAR_PROJECT_KEY`.

El analisis ya viene configurado en `sonar-project.properties`. No hay que
editar ese archivo.

## Preparacion previa

Con los secretos de AWS cargados, ejecutar el workflow **`setup-infra`** a mano,
pasandole el nombre del bucket de estado (`inf384-tfstate-<su-codigo-pucp>`).
Crea las tres cosas que el pipeline de infraestructura necesita para poder
correr: el bucket del archivo de estado, el repositorio privado de imagenes y
una imagen inicial de marcador de posicion.

Esa imagen existe solo para desbloquear la creacion de la funcion. Una funcion
Lambda de tipo imagen exige que la imagen ya este en el registro, y Terraform
no publica imagenes.

Al terminar, el resumen de la ejecucion imprime el contenido de
`infra/backend.hcl`. Crear ese archivo con ese contenido exacto y **versionarlo**:
el pipeline de infraestructura lo lee en el runner y ahi no hay forma de
generarlo. Ese mismo commit toca `infra/`, asi que dispara el pipeline, y su
primera ejecucion crea el grupo de logs, la politica de descarga y la funcion.

## Estructura

| Ruta | Contenido |
|---|---|
| `src/` | La funcion |
| `test/` | Pruebas unitarias |
| `infra/` | Terraform: repositorio de imagenes, politica de descarga, grupo de logs y funcion |
| `sonar-project.properties` | Configuracion del analisis de calidad. Viene resuelta |
| `.github/workflows/` | Pipeline de aplicacion, pipeline de infraestructura, construccion de la imagen y verificacion de credenciales |

## Guia

El enunciado, la preparacion previa, la rubrica y el entregable estan en el aula
virtual del curso, en `INF384 · Laboratorio 3`. La preparacion previa se ejecuta
antes de la sesion.
