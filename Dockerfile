# Imagen de la funcion Lambda, construida en dos etapas.
#
# build   instala las dependencias desde el lock file y empaqueta el handler
#         con esbuild en un solo archivo, dist/handler.js.
# runtime recibe solo ese archivo. Sin node_modules, sin codigo fuente y sin
#         herramientas: lo que corre en produccion es el artefacto empaquetado.

# Version fija de la imagen base (corrige defecto 1: tag movil 'latest').
# La misma base en las dos etapas: el artefacto se construye con el mismo
# Node que lo ejecuta.
FROM public.ecr.aws/lambda/nodejs:20.2026.04.30.13 AS build

WORKDIR /build

# Manifiesto y lock file antes del codigo (corrige defecto 2: COPY . .).
# La capa de dependencias se reutiliza mientras el lock file no cambie.
COPY package.json package-lock.json ./

# Instalacion desde el lock file (corrige defecto 3: npm install).
# Incluye devDependencies porque esbuild es una de ellas.
RUN npm ci

COPY src ./src
RUN npm run build


FROM public.ecr.aws/lambda/nodejs:20.2026.04.30.13 AS runtime

# Sin credenciales declaradas (corrige defecto 4). La configuracion llega
# como variable de entorno de la funcion, declarada en infra/.
#
# Sin gestor de paquetes ni herramientas de depuracion (corrige defecto 5):
# esta etapa no ejecuta ningun RUN.
#
# Solo el artefacto empaquetado pasa a la etapa final.
COPY --from=build /build/dist/handler.js ${LAMBDA_TASK_ROOT}/handler.js

CMD ["handler.handler"]
