// La version de la aplicacion llega por variable de entorno.
// La definicion de la funcion en infra/ es la duena de ese valor.
// El valor por defecto solo aplica en ejecucion local y en las pruebas.
const VERSION_POR_DEFECTO = '0.0.0-local';

function obtenerVersion() {
  const declarada = process.env.APP_VERSION;
  if (!declarada) {
    return VERSION_POR_DEFECTO;
  }
  return declarada.trim();
}

module.exports = { obtenerVersion, VERSION_POR_DEFECTO };
