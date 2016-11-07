import org.json.simple.JSONObject;

import java.io.Serializable;

/**
 * Created by Simon Buchholz on 02.11.2016.
 */
public class Microservice implements Serializable {



    /** used as key in the p2p network */
    private String name;

    /** metadata */
    private String description;
    private String endpoint;

    private JSONObject swaggerJson;

    public Microservice(String name, String description, String endpoint) {
        this.name = name;
        this.description = description;
        this.endpoint = endpoint;
    }

    public Microservice(String name, String description, String endpoint, JSONObject swaggerJson) {
        this.name = name;
        this.description = description;
        this.endpoint = endpoint;
        this.swaggerJson = swaggerJson;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public JSONObject getSwaggerJson() {
        return swaggerJson;
    }

    @Override
    public String toString() {
        return "Microservice{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", endpoint='" + endpoint + '\'' +
                '}';
    }
}
