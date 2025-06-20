@REQ_MXP-01 @HU01 @obtener_personajes @testuser_api_characters @Agente2 @E2 @iniciativa_personajes
Feature: REQ_MXP-01 Obtener personajes (microservicio para gestión de personajes)
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

  @id:1 @obtenerPersonajes @solicitudExitosa200
  Scenario: T-API-REQ_MXP-01-CA01-Obtener personajes exitosamente 200 - karate
    And request {}
    When method GET
    Then status 200
    * def personajes = response
    * print 'Respuesta de GET personajes:', personajes
    * def primerId = karate.sizeOf(personajes) > 0 && personajes[0].id ? personajes[0].id : 1
    * print 'ID calculado para reutilizar:', primerId
    # And match response != null
    # And match response == karate.read('classpath:data/testuser_api_characters/response_get_characters_200.json')


  @id:2 @obtenerPersonajes @errorValidacion404
  Scenario: T-API-REQ_MXP-01-CA02-Obtener personajes con solicitud inválida 404 - karate
    And request { invalid: true }
    When method GET
    * path '99999'
    Then status 404
    # And match response.message contains 'Solicitud inválida'
    # And match response.status == 400

  @id:3 @obtenerPersonajes @errorServicio500
  Scenario: T-API-REQ_MXP-01-CA03-Obtener personajes con error interno 500 - karate
    * path '/testuser/api/characters/'
    And request { error: true }
    When method GET
    Then status 500
    # And match response.status == 500
    # And match response.message contains 'Error interno del servidor'
