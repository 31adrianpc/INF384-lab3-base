// La configuracion de cobertura viene resuelta en el repositorio base.
// El reporte lcov queda en coverage/lcov.info y es consumible por un
// analizador externo. El reporte json-summary deja las cifras agregadas
// en coverage/coverage-summary.json.
module.exports = {
  testEnvironment: 'node',
  collectCoverageFrom: ['src/**/*.js'],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'json-summary'],
};
