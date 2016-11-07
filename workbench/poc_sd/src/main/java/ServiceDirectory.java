import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.util.*;

import index.InvertedIndex;
import net.tomp2p.futures.FutureDHT;
import net.tomp2p.futures.FutureBootstrap;
import net.tomp2p.p2p.Peer;
import net.tomp2p.p2p.PeerMaker;
import net.tomp2p.peers.Number160;
import net.tomp2p.storage.Data;

import java.io.FileReader;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


/**
 * Created by Simon Buchholz on 02.11.2016.
 */
public class ServiceDirectory {

    /**
     * The client peer of the P2P network
     */
    private Peer peer;

    /**
     * Port number of the seeding peer
     */
    private static final int SEEDING_PEER_PORT = 4001;

    /**
     * Identifier of the seeding peer
     */
    private static final String SEEDING_PEER = "Seeding peer";

    /**
     * the prompt of the shell
     */
    private static final String PROMPT = "service-registry> ";

    /**
     * command to put a value to the P2P network
     */
    private static final String CMD_PUT = "put";

    /**
     * command to query a value from the P2P network
     */
    private static final String CMD_GET = "get";

    /**
     * command to register a service in the directory
     */
    private static final String CMD_REGISTER = "register";

    /**
     * command to search for a service in the directory
     */
    private static final String CMD_SEARCH = "search";

    /**
     * command to lookup a specific service from the directory
     */
    private static final String CMD_LOOKUP = "lookup";

    /**
     * command to terminate the shell
     */
    private static final String CMD_QUIT = "quit";


    /**
     * Starts a peer listening to the given port
     *
     * @param port
     * @throws Exception
     */
    public ServiceDirectory(int port) throws Exception {
        // First, a peer with an ID has to be created. You can either set a random peer ID, or you can create
        // the peer with a KeyPair, which takes a public key and generates the ID (SHA-1) out of this key.
        KeyPairGenerator gen = KeyPairGenerator.getInstance("DSA");
        KeyPair pair1 = gen.generateKeyPair();

        // You can either create a new peer and listen to another port, or you can attach a new peer to an existing port
        // of the master peer. The later is more resource friendly and many thousands of peers can be created.
        peer = new PeerMaker(pair1).setPorts(port).makeAndListen();
        // Peer another = new PeerMaker(pair1).setMasterPeer(peer).makeAndListen();

        // Then we bootstrap to a well known peer
        FutureBootstrap fb = peer.bootstrap().setBroadcast().setPorts(SEEDING_PEER_PORT).start();
        fb.awaitUninterruptibly();
        if (fb.getBootstrapTo() != null) {
            peer.discover().setPeerAddress(fb.getBootstrapTo().iterator().next()).start().awaitUninterruptibly();
        }
    }

    /**
     * Sets up a bootstrap peer
     *
     * @throws Exception
     */
    public ServiceDirectory() throws Exception {
        peer = new PeerMaker(Number160.createHash(SEEDING_PEER)).setPorts(SEEDING_PEER_PORT).makeAndListen();
        FutureBootstrap fb = peer.bootstrap().setBroadcast().setPorts(SEEDING_PEER_PORT).start();
        fb.awaitUninterruptibly();
        if (fb.getBootstrapTo() != null) {
            peer.discover().setPeerAddress(fb.getBootstrapTo().iterator().next()).start().awaitUninterruptibly();
        }
    }

    public static void main(String[] args) throws NumberFormatException, Exception {

        ServiceDirectory dns = null;
        if (args.length == 1 && args[0].equals("seed")) {
            dns = new ServiceDirectory();
            System.out.println("Master peer. Port: " + SEEDING_PEER_PORT);
        } else if (args.length == 1) {
            dns = new ServiceDirectory(Integer.parseInt(args[0]));
            System.out.println("Peer joined the network. Port: " + args[0]);
        }

        boolean quit = false;
        while (!quit && dns != null) {
            final String[] tokens = Terminal.askString(PROMPT).trim()
                    .split("\\s+");
            final String cmd = tokens[0];

            if (CMD_QUIT.equals(cmd)) {
                quit = true;
            } else if (CMD_PUT.equals(cmd)) {
                if (tokens.length >= 2) {
                    dns.store(tokens[1], tokens[2]);
                } else {
                    System.out.println("Insufficient number of arguments!");
                }
            } else if (CMD_GET.equals(cmd)) {
                if (tokens.length >= 1) {
                    System.out.println(dns.get(tokens[1]));
                } else {
                    System.out.println("Insufficient number of arguments!");
                }
            } else if (CMD_REGISTER.equals(cmd)) {
                if (tokens.length >= 5) {
                    dns.registerService(tokens[1], tokens[2], tokens[3], tokens[4]);
                } else if (tokens.length == 2) {
                    try {
                        dns.registerService(tokens[1]);
                    } catch (FileNotFoundException e) {
                        System.out.println("File not found!");
                    }
                } else {
                    System.out.println("Insufficient number of arguments!");
                }
            } else if (CMD_SEARCH.equals(cmd)) {
                if (tokens.length != 0) {
                    String searchTerm = Terminal.askString(PROMPT + "Please enter your search term: ");
                    dns.searchService(searchTerm);
                } else {
                    System.out.println("Insufficient number of arguments!");
                }
            } else if (CMD_LOOKUP.equals(cmd)) {
                if (tokens.length == 2) {
                    System.out.println(dns.getService(tokens[1]).toString());
                    System.out.println("Swagger JSON: " + dns.getService(tokens[1]).getSwaggerJson().toString());
                } else {
                    System.out.println("Insufficient number of arguments!");
                }
            } else {
                System.out.println("Unknown command: " + cmd);
            }
        }
    }

    /**
     * Get a value from the P2P network
     *
     * @param name
     * @return
     * @throws ClassNotFoundException
     * @throws IOException
     */
    private String get(String name) throws ClassNotFoundException, IOException {
        FutureDHT futureDHT = peer.get(Number160.createHash(name)).start();
        futureDHT.awaitUninterruptibly();
        if (futureDHT.isSuccess()) {
            return futureDHT.getData().getObject().toString();
        }
        return "not found";
    }

    /**
     * Put a value to the P2P network
     *
     * @param name
     * @param value
     * @throws IOException
     */
    private void store(String name, String value) throws IOException {
        peer.put(Number160.createHash(name)).setData(new Data(value)).start().awaitUninterruptibly();
        System.out.println("Peer:" + peer.getPeerID() + " put:" + name + ", " + value);
    }

    /**
     * Register a service to the P2P network
     *
     * @param serviceName
     * @param description
     * @param endpoint
     * @throws IOException
     */
    public void registerService(String serviceName, String description, String endpoint, String swaggerUri) throws IOException {
        JSONObject jsonSwagger = null;
        if (!swaggerUri.equals("null")) {
            JSONParser parser = new JSONParser();
            Object swaggerObj;
            try {
                swaggerObj = parser.parse(new FileReader(swaggerUri));
                jsonSwagger = (JSONObject) swaggerObj;
            } catch (ParseException | FileNotFoundException e) {
                System.out.println("Swagger file not found!");
                jsonSwagger = null;
            }
        }

        Microservice service = new Microservice(serviceName, description, endpoint, jsonSwagger);
        peer.put(Number160.createHash(serviceName)).setData(new Data(service)).start().awaitUninterruptibly();
        Map<String, Integer> serviceDescriptionIndex = InvertedIndex.indexText(description);
        storeIndex(serviceName, serviceDescriptionIndex);
        Map<String, Integer> serviceNameIndex = InvertedIndex.indexText(serviceName);
        storeIndex(serviceName, serviceNameIndex);
        System.out.println("Peer:" + peer.getPeerID() + " service registered: " + serviceName);
    }


    public void registerService(String jsonUri) throws IOException, ParseException {

        JSONParser parser = new JSONParser();

        Object obj = parser.parse(new FileReader(jsonUri));

        JSONObject jsonObject = (JSONObject) obj;

        String name = (String) jsonObject.get("name");
        String description = (String) jsonObject.get("description");
        String endpoint = (String) jsonObject.get("endpoint");
        String swaggerUri = (String) jsonObject.get("swagger-file");

        registerService(name, description, endpoint, swaggerUri);
    }

    /**
     * Put the inverted search index for the given service to the P2P network
     *
     * @param serviceName
     * @param serviceIndex
     * @throws IOException
     */
    private void storeIndex(String serviceName, Map<String, Integer> serviceIndex) throws IOException {
        serviceIndex.forEach((word, occurrence) -> {
            try {
                InvertedIndex oldIndex = getIndex(word);
                if (oldIndex != null) {
                    oldIndex.put(serviceName, occurrence);
                    peer.put(Number160.createHash(word)).setData(new Data(oldIndex)).start().awaitUninterruptibly();
                } else {
                    InvertedIndex wordIndex = new InvertedIndex(word, serviceName, occurrence);
                    peer.put(Number160.createHash(word)).setData(new Data(wordIndex)).start().awaitUninterruptibly();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

    /**
     * Search for services in the directory.
     *
     * @param searchTerm
     * @return Returns a map containing the service name and the corresponding search rank
     */
    public HashMap<String, Integer> searchService(String searchTerm) {

        String[] words = searchTerm.toLowerCase().trim().split("\\s+");

        // search results: service identifier, search score
        HashMap<String, Integer> searchResults = new HashMap<>();

        // collecting all inverted indexes from the peers
        List<InvertedIndex> indexes = new ArrayList<InvertedIndex>();
        for (String word : words) {
            InvertedIndex tmp = getIndex(word);
            if (tmp != null) indexes.add(tmp);
        }
        // TODO: In order to further improve the service discovery performance of the directory, we could
        // TODO: cache the frequently used indexes

        // Computing very easy search score with the occurrence of search terms
        indexes.forEach(invertedIndex -> {
            for (Map.Entry<String, Integer> entry : invertedIndex.getMicroServices().entrySet()) {
                if (searchResults.containsKey(entry.getKey())) {
                    searchResults.put(entry.getKey(), searchResults.get(entry.getKey()) + entry.getValue());
                } else {
                    searchResults.put(entry.getKey(), entry.getValue());
                }
            }
        });

        // Print the top ten search results
        System.out.println("Search results:");
        searchResults.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(10)
                .forEach(stringIntegerEntry -> {
                    Microservice tmpService = getService(stringIntegerEntry.getKey());
                    System.out.println(tmpService.toString());
                });

        return searchResults;
    }

    /**
     * Get a specific service from the directory (identified by the service name)
     *
     * @param name
     * @return
     */
    public Microservice getService(String name) {
        FutureDHT futureDHT = peer.get(Number160.createHash(name)).start();
        futureDHT.awaitUninterruptibly();

        if (futureDHT.isSuccess()) {
            try {
                if (futureDHT.getData().getObject() instanceof Microservice) {
                    return (Microservice) futureDHT.getData().getObject();
                }
            } catch (ClassNotFoundException | IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * Get the search index for one specific word
     *
     * @param word
     * @return
     */
    private InvertedIndex getIndex(String word) {
        FutureDHT futureDHT = peer.get(Number160.createHash(word)).start();
        futureDHT.awaitUninterruptibly();

        if (futureDHT.isSuccess()) {
            try {
                if (futureDHT.getData().getObject() instanceof InvertedIndex) {
                    return (InvertedIndex) futureDHT.getData().getObject();
                }
            } catch (ClassNotFoundException | IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}