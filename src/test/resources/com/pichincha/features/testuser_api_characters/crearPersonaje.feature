@REQ_MXP-01 @HU01 @crear_personaje @testuser_api_characters @Agente2 @E2 @iniciativa_personajes
Feature: REQ_MXP-01 Crear personaje (microservicio para gestión de personajes)
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

  @id:1 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-REQ_MXP-01-CA01-Crear personaje exitosamente 201 - karate
    * def nombre = 'Iron Man MK ' + (Math.floor(Math.random()*100000))
    * def alterego = 'Tony Stark MK ' + (Math.floor(Math.random()*100000))
    * def jsonData = { name: '#(nombre)', alterego: '#(alterego)', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }


    And request jsonData
    When method POST
    Then status 201
    # And match response != null
    # And match response.name == jsonData.name

  @id:2 @crearPersonaje @errorValidacion400
  Scenario: T-API-REQ_MXP-01-CA02-Crear personaje con datos inválidos 400 - karate
    * def jsonData = read('classpath:data/testuser_api_characters/request_create_character.json')
    * set jsonData.name = null
    And request jsonData
    When method POST
    Then status 400
    # And match response.message contains 'Datos inválidos'
    # And match response.status == 400

  @id:3 @crearPersonaje @errorServicio500
  Scenario: T-API-REQ_MXP-01-CA03-Crear personaje con error interno 500 - karate
    * def jsonData = read('classpath:data/testuser_api_characters/request_create_character_500.json')
    * set jsonData.name = 'error500'
    And request jsonData
    When method POST
    Then status 500
    # And match response.status == 500
    # And match response.message contains 'Error interno del servidor'
