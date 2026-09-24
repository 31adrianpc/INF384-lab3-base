const { handler, leerSesion, NOMBRE_COOKIE_SESION } = require('../src/handler');
const { VERSION_POR_DEFECTO } = require('../src/version');

const ISO_8601 = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/;

describe('handler', () => {
  const entornoOriginal = process.env.APP_VERSION;

  afterEach(() => {
    if (entornoOriginal === undefined) {
      delete process.env.APP_VERSION;
    } else {
      process.env.APP_VERSION = entornoOriginal;
    }
  });

  test('responde ok sin evento', async () => {
    delete process.env.APP_VERSION;
    const respuesta = await handler();
    expect(respuesta.ok).toBe(true);
    expect(respuesta.version).toBe(VERSION_POR_DEFECTO);
    expect(respuesta.sesion).toBeNull();
  });

  test('la marca de tiempo es ISO 8601 en UTC', async () => {
    const respuesta = await handler({});
    expect(respuesta.marcaDeTiempo).toMatch(ISO_8601);
  });

  test('cada invocacion produce un identificador distinto', async () => {
    const primera = await handler({});
    const segunda = await handler({});
    expect(primera.idPeticion).not.toBe(segunda.idPeticion);
  });

  test('toma la version de la variable de entorno', async () => {
    process.env.APP_VERSION = '  1.4.0  ';
    const respuesta = await handler({});
    expect(respuesta.version).toBe('1.4.0');
  });

  test('extrae el marcador de sesion de la cabecera del evento', async () => {
    const respuesta = await handler({
      headers: { cookie: `${NOMBRE_COOKIE_SESION}=abc123` },
    });
    expect(respuesta.sesion).toBe('abc123');
  });
});

describe('leerSesion', () => {
  test('acepta la cabecera con mayuscula inicial', () => {
    expect(leerSesion({ Cookie: `${NOMBRE_COOKIE_SESION}=xyz` })).toBe('xyz');
  });

  test('ignora una cookie de otro nombre', () => {
    expect(leerSesion({ cookie: 'otra=1' })).toBeNull();
  });

  test('devuelve null cuando no hay cabecera', () => {
    expect(leerSesion({})).toBeNull();
  });
});
