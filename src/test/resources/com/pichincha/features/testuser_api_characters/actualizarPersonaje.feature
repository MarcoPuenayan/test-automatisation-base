@REQ_MXP-01 @HU01 @actualizar_personaje @testuser_api_characters @Agente2 @E2 @iniciativa_personajes
Feature: REQ_MXP-01 Actualizar personaje (microservicio para gestión de personajes)
  Background:
    * url port_testuser_api_characters
    * path '/testuser/api/characters'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @actualizarPersonaje @solicitudExitosa200
  Scenario: T-API-REQ_MXP-01-CA01-Actualizar personaje exitosamente 200 - karate
    * def getResult = callonce read('classpath:com/pichincha/features/testuser_api_characters/getCharacters.feature@T-API-REQ_MXP-01-CA01-Obtener personajes exitosamente 200 - karate')
    * print 'ID obtenido de getCharacters:', getResult.primerId
    * def idActualizar = getResult.primerId
    * def jsonData = read('classpath:data/testuser_api_characters/request_update_character.json')
    * def nombre = 'Iron Man MK ' + (Math.floor(Math.random()*100000))
    * def alterego = 'Tony Stark MK ' + (Math.floor(Math.random()*100000))
    * def jsonData = { name: '#(nombre)', alterego: '#(alterego)', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }
    * path '/testuser/api/characters/', idActualizar
    And request jsonData
    When method PUT
    Then status 200
    # And match response != null
    # And match response == karate.read('classpath:data/testuser_api_characters/response_update_character_200.json')

  @id:2 @actualizarPersonaje @errorValidacion400
  Scenario: T-API-REQ_MXP-01-CA02-Actualizar personaje con datos inválidos 400 - karate
    * def jsonData = read('classpath:data/testuser_api_characters/request_update_character.json')
    * set jsonData.name = null
    And request jsonData
    When method PUT
    And path '1'
    Then status 400
    # And match response.message contains 'Datos inválidos'
    # And match response.status == 400

  @id:3 @actualizarPersonaje @errorServicio500
  Scenario: T-API-REQ_MXP-01-CA03-Actualizar personaje con error interno 500 - karate
    * def jsonData = read('classpath:data/testuser_api_characters/request_update_character.json')
    * set jsonData.name = 'error500'
    And request jsonData
    When method PUT
    And path '1'
    Then status 500
    # And match response.status == 500
    # And match response.message contains 'Error interno del servidor'
