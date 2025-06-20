@REQ_MXP-01 @HU01 @eliminar_personaje @testuser_api_characters @Agente2 @E2 @iniciativa_personajes
Feature: REQ_MXP-01 Eliminar personaje (microservicio para gestión de personajes)
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

  @id:1 @eliminarPersonaje @solicitudExitosa200
  Scenario: T-API-REQ_MXP-01-CA01-Eliminar personaje exitosamente 200 - karate
    And request {}
    When method DELETE
    And path '1'
    Then status 200
    # And match response.message contains 'eliminado exitosamente'
    # And match response == karate.read('classpath:data/testuser_api_characters/response_delete_character_200.json')

  @id:2 @eliminarPersonaje @noEncontrado404
  Scenario: T-API-REQ_MXP-01-CA02-Eliminar personaje no encontrado 404 - karate
    And request {}
    When method DELETE
    And path '99999'
    Then status 404
    # And match response.message contains 'no encontrado'
    # And match response.status == 404

  @id:3 @eliminarPersonaje @errorServicio500
  Scenario: T-API-REQ_MXP-01-CA03-Eliminar personaje con error interno 500 - karate
    And request {}
    When method DELETE
    And path 'error500'
    Then status 500
    # And match response.status == 500
    # And match response.message contains 'Error interno del servidor'
