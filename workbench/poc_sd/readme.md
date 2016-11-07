# Proof of concept: DHT based service discovery (SD) system

You can find my ideas here: https://docs.google.com/presentation/d/1tJ8Sq1QrTqfQctG84Pw1RZAHen7suHAcyEaGD_UtZHI/edit?usp=sharing

Distributed hash table based P2P systems are extremely effective for searching resources using unique identifiers, but they fail when a search using partial matching is required.

More information about the approach can be found in the papers [A survey on resource discovery mechanisms, peer-to-peer and service discovery frameworks] and [Efficient Peer-to-Peer Keyword Searching].

This is a PoC that extends the [TomP2P] DHT library by inverted indexes and thus gives the system the ability of effective service discovery.

With inverted indexes we can provide keyword search functionality for a DHT-based SD system. The idea is following: 

- mapping each keyword to a node in the DHT that will store a list of documents containing that keyword
- The overall inverted index is distributed over the peers
- Furthermore (not yet in this PoC): use caches for frequently used indexes

## Try it out

There are 2 ways you can try it out:
1. Simply import as maven project and run the `Example.java` main. It will register the service mocks provided in the `microservice.json` files
2. Using the CLI

### Using the CLI

First you need to run the `ServiceDirectory.java` with "seed" as program argument. This starts a bootstrap peer, since there are no existing peers running yet.

```sh
java ServiceDirectory seed
```

Then you can start one or more other peers by providing a port number as program argument.

```sh
java ServiceDirectory 4002
```

##### Register a microservice

You can register a new microservice and its swagger description by typing `register` and provide a json file with some service information in it. Look at `microservice_calculator.json` for example.

```sh
service-registry> register microservice_calculator.json
```

##### Keyword search for microservices

You can search for services by typing `search`. Then you need to type in the keyword(s) that you are searching for.

```sh
service-registry> search
service-registry> Please enter your search term: numbers
Search results:
...
```

##### Lookup specific service

If you want to lookup a specific service's metadata, you need to type `lookup` and provide the exact name of the service.

```sh
service-registry> lookup servicename
```


   [Efficient Peer-to-Peer Keyword Searching]: <http://issg.cs.duke.edu/search/search.pdf>
   [A survey on resource discovery mechanisms, peer-to-peer and service discovery frameworks]: <http://www.sciencedirect.com/science/article/pii/S138912860800100X?np=y>
   [TomP2P]: <https://tomp2p.net>
