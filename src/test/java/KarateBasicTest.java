import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }
    @Karate.Test
    Karate testBasic() {
        return Karate.run(
        "classpath:com/pichincha/features/testuser_api_characters/crearPersonaje.feature",
        "classpath:com/pichincha/features/testuser_api_characters/getCharacters.feature",
        "classpath:com/pichincha/features/testuser_api_characters/actualizarPersonaje.feature",
        "classpath:com/pichincha/features/testuser_api_characters/eliminarPersonaje.feature"
    );
    }

}
