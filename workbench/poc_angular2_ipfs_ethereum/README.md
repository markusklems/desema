# MarketClient

A simple proof of concept, that shows how we could combine IPFS and Ethereum in an Angular2 application.

What this application does:
* Using the ipfs-api library, it connects to a separately running IPFS daemon
* Using the web3.js library, it connects to a locally running ethereum client (e.g. the geth client)
* You can enter some data and add them to IPFS

## Set up your environment
1. Download and install the node package manager (npm)
2. Download and install an ethereum client (e.g. geth)
3. Download and install IPFS
4. Install the angular CLI by `npm install -g angular-cli`

## Useful resources

* [IPFS API reference](http://docs.ipfs.apiary.io/)
* [IPFS Command reference](https://ipfs.io/docs/commands/)
 

### Angular2 CLI
The Angular2 CLI was used to create some of the files of this project. You can of course create all the modules, components and the overall structure by hand. But the CLI offers a simple and quick possibility to do all of this automatic.

E.g. if you want to generate a new empty component, you can do it by running `ng g component my-new-component`.

To get more help on the `angular-cli` use `ng --help` or go check out the [Angular-CLI README](https://github.com/angular/angular-cli/blob/master/README.md).

## Getting started
### 1. Running the IPFS daemon with the right port
To interact with the IPFS API, you need to have a local daemon running. It needs to be open on the right port. 5001 is the default, and is used in the examples below, but it can be set to whatever you need.
Furthermore it is necessary to have to add the domain of our application to the IPFS whitelist, so we don't run into a CORS (Cross Origin Resource Sharing) error.

```
# Run the daemon
$ ipfs daemon
 
# In another terminal do the following: 
# Show the ipfs config API port to check it is correct
$ ipfs config Addresses.API
/ip4/127.0.0.1/tcp/5001
# Set it if it does not match the above output
$ ipfs config Addresses.API /ip4/127.0.0.1/tcp/5001
 
# Put our domain to the whitelist of the daemon to avoid CORS failures
$ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"http://localhost:4200\"]"
$ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials "[\"true\"]"
$ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"PUT\", \"POST\", \"GET\"]"
  
# Restart the daemon after changing the config
# Run the daemon
$ ipfs daemon
```

### 2. Start ethereum client
To talk to an ethereum node from inside a JavaScript application we use the web3.js library, which gives an convenient
interface for the RPC methods. See the JavaScript API for more.

You need to start your client with the --rpc flag, in order to connect to it from the javascript application. Because we are accessing the RPC from a browser, CORS will need to be enabled with the appropriate domain set. Otherwise, JavaScript calls are limit by the same-origin policy and requests will fail:
`geth --rpc --rpccorsdomain "http://localhost:4200"`

If you don't want to use the default port (8545), you can change the default HTTP-RPC port with:
`geth --rpc --rpccorsdomain "http://localhost:4200" --rpcport <portnumber>`

### 3. Run the angular app
First thing you need to do is downloading all the dependencies. You do it by navigating to the project directory and running `npm install` (Node package manager must be installed)

Then you can run a dev server by typing `ng serve`. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

The application automatically starts an IPFS deamon from the Browser and shows you some details for it. Now you can also connect the angular app to the running ethereum client on your computer by providing the HTTP-RPC host address (default: http:localhost:8545/ ).

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

To run the app on another host address than the default one (localhost:4200), run `ng serve --host 0.0.0.0 --port 4200`

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).
Before running the tests make sure you are serving the app via `ng serve`.

## Deploying to Github Pages

Run `ng github-pages:deploy` to deploy to Github Pages.
