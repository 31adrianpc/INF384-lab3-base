# Dockerfile del repositorio base.
# Contiene cinco malas practicas deliberadas. Cada una lleva su numero en la
# linea anterior. Corregirlas es el bloque A1 de la guia del laboratorio.

# defecto 1
FROM public.ecr.aws/lambda/nodejs:latest

# defecto 2
COPY . .

# defecto 3
RUN npm install

# defecto 4
ENV DB_PASSWORD="inf384-clave-en-texto-plano"

# defecto 5
RUN dnf install -y procps-ng vim && dnf clean all

CMD ["src/handler.handler"]
