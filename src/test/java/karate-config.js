function fn() {
  var env = karate.env || 'local';

  // Configuración base para todos los entornos
  var config = {
    baseUrl: 'http://localhost:8080'
  };

  // URLs para todos los microservicios (nombrados con formato port_nombre_microservicio)
  config.port_testuser_api_characters = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';

  // Configuración específica por entorno
  if (env == 'dev') {
    config.baseUrl = 'https://api-dev.empresa.com';
    config.port_testuser_api_characters = 'https://api-dev.empresa.com/testuser-api-characters';
  } 
  else if (env == 'qa') {
    config.baseUrl = 'https://api-qa.empresa.com';
    config.port_testuser_api_characters = 'https://api-qa.empresa.com/testuser-api-characters';
  }

  return config;
}
