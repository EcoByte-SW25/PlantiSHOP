package auxs;

import io.github.cdimascio.dotenv.Dotenv;

public class Llavero {
    
    private static final Dotenv env = Dotenv.configure().load();
    
    public static String getClave1() {
        return env.get("CLAVE_1");
    }

    public static String getApiGoogleMaps() {
        return env.get("API_GOOGLEMAPS");
    }

    public static String getClave2() {
        return env.get("CLAVE_2");
    }

    public static String getApiOpenAi() {
        return env.get("API_OPENAI");
    }

    public static String getClave3() {
        return env.get("CLAVE_3");
    }

    public static String getApiPlantNet() {
        return env.get("API_PLANTNET");
    }
    
}