/**
 * Created by Simon Buchholz on 02.11.2016.
 */
public class Example {

    public static void main(String[] args) throws Exception {
        ServiceDirectory bootstrapPeer;
        ServiceDirectory secondPeer;
        ServiceDirectory thirdPeer;

        System.out.println("Register services:");
        // 1. Start bootstrap node for P2P network
        bootstrapPeer = new ServiceDirectory();
        // 2. Start two other peers listening to the ports 4002 and 4003
        secondPeer = new ServiceDirectory(4002);
        thirdPeer = new ServiceDirectory(4003);

        // Register some services at node 2 and 3
        secondPeer.registerService("microservice_calculator.json");
        secondPeer.registerService("microservice_randomnumber.json");
        thirdPeer.registerService("microservice_randomtext.json");
        secondPeer.registerService("microservice_translator.json");

        // Search for services with a search term
        thirdPeer.searchService("Random numbers");

        // Lookup a specific service and print its Swagger description
        System.out.println("Lookup Calculator service:");
        Microservice service = secondPeer.getService("Calculator");
        System.out.println(service.toString());
        System.out.println("Swagger JSON: " + service.getSwaggerJson().toString());
    }
}