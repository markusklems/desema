# MarketClient

A simple proof of concept, that shows how we could combine IPFS and Ethereum in an Angular2 application.

What this application does:
* Using the js-ipfs library, it starts an IPFS deamon from the browser
* Using the web3.js library, it connects to a locally running ethereum client (e.g. the geth client)
* You can enter some data and add them to IPFS

## Getting started
### 1. Start ethereum client
To talk to an ethereum node from inside a JavaScript application we use the web3.js library, which gives an convenient
interface for the RPC methods. See the JavaScript API for more.

You need to start your client with the --rpc flag, in order to connect to it from the javascript application. Because we are accessing the RPC from a browser, CORS will need to be enabled with the appropriate domain set. Otherwise, JavaScript calls are limit by the same-origin policy and requests will fail:
`geth --rpc --rpccorsdomain "http://localhost:4200"`

If you don't want to use the default port (8545), you can change the default HTTP-RPC port with:
`geth --rpc --rpccorsdomain "http://localhost:4200" --rpcport <portnumber>`

### 2. Run the angular app
First thing you need to do is downloading all the dependencies. You do it by navigating to the project directory and running `npm install` (Node package manager must be installed)

Then you can run a dev server by typing `ng serve`. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

The application automatically starts an IPFS deamon from the Browser and shows you some details for it. Now you can also connect the angular app to the running ethereum client on your computer by providing the HTTP-RPC host address (default: http:localhost:8545/ ).

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).
Before running the tests make sure you are serving the app via `ng serve`.

## Deploying to Github Pages

Run `ng github-pages:deploy` to deploy to Github Pages.

## Further help

To get more help on the `angular-cli` use `ng --help` or go check out the [Angular-CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
