# DroneCI (v0.5) 

DroneCI is a CI/CD pipeline which allows local CI runs and remote CD runs, which update the repository of the source code.

### Run the tests locally

Install the drone binary from [here](http://readme.drone.io/usage/getting-started-cli/) and execute the following..

```
$ drone exec --repo.trusted --privileged build 
```

It will start a matrix job, which firsts starts ipfs and ethereum:

```
Running Matrix job #0
[ipfs:L0:0s] ipfs version 0.4.4
[ipfs:L1:0s] initializing ipfs node at /data/ipfs
[ipfs:L2:0s] generating 2048-bit RSA keypair...done
[ipfs:L3:0s] peer identity: QmY2inJB9ajsFEXDRvzZbjpewZtsnrfRQKgTAkHypNDBA3
[geth:L0:0s] I0103 19:49:23.796518 cmd/utils/flags.go:613] WARNING: No etherbase set and no accounts found as default
[geth:L1:0s] I0103 19:49:23.796908 ethdb/database.go:83] Allotted 128MB cache and 1024 file handles to /root/.ethereum/geth/chaindata
[geth:L2:0s] I0103 19:49:23.849732 ethdb/database.go:176] closed db:/root/.ethereum/geth/chaindata
[geth:L3:0s] I0103 19:49:23.851331 node/node.go:175] instance: Geth/v1.5.2-stable-c8695209/linux/go1.7.3
[geth:L4:0s] I0103 19:49:23.851420 ethdb/database.go:83] Allotted 128MB cache and 1024 file handles to /root/.ethereum/geth/chaindata
[geth:L5:0s] I0103 19:49:23.910778 eth/db_upgrade.go:346] upgrading db log bloom bins
[geth:L6:0s] I0103 19:49:23.910900 eth/db_upgrade.go:354] upgrade completed in 124.261µs
[geth:L7:0s] I0103 19:49:23.910936 eth/backend.go:193] Protocol Versions: [63 62], Network Id: 1
[geth:L8:0s] I0103 19:49:23.911410 core/blockchain.go:214] Last header: #0 [cbd8bf76…] TD=1
[geth:L9:0s] I0103 19:49:23.911440 core/blockchain.go:215] Last block: #0 [cbd8bf76…] TD=1
[geth:L10:0s] I0103 19:49:23.911451 core/blockchain.go:216] Fast block: #0 [cbd8bf76…] TD=1
[geth:L11:0s] I0103 19:49:23.912039 p2p/server.go:336] Starting Server
[ipfs:L4:0s] to get started, enter:
[ipfs:L5:0s]
[ipfs:L6:0s] 	ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme
[ipfs:L7:0s]
[ipfs:L8:1s] Initializing daemon...
[geth:L12:2s] I0103 19:49:26.028131 p2p/discover/udp.go:217] Listening, enode://f2c1c13c7d447e97398fa6753bcb0536e0dd5e487b742476ab7b7cb232c2b040d66ea1774cb41b8bda03b918320ad1fedb242916e6df0aea58feecb24302660d@[::]:30303
[geth:L13:2s] I0103 19:49:26.031177 node/node.go:410] HTTP endpoint opened: http://localhost:8545
[geth:L14:2s] I0103 19:49:26.031566 p2p/server.go:604] Listening on [::]:30303
[geth:L15:2s] I0103 19:49:26.033399 node/node.go:340] IPC endpoint opened: /root/.ethereum/geth.ipc
[ipfs:L9:3s] Swarm listening on /ip4/127.0.0.1/tcp/4001
[ipfs:L10:3s] Swarm listening on /ip4/172.17.0.2/tcp/4001
[ipfs:L11:3s] Swarm listening on /ip6/::1/tcp/4001
[ipfs:L12:3s] API server listening on /ip4/0.0.0.0/tcp/5001
[ipfs:L13:3s] Gateway (readonly) server listening on /ip4/0.0.0.0/tcp/8080
[ipfs:L14:3s] Daemon is ready
```

Afterwards it will start the test...

```
[build:L0:0s] + npm install typescript
[build:L1:0s] npm info it worked if it ends with ok
[build:L2:0s] npm info using npm@3.10.9
[build:L3:0s] npm info using node@v6.9.2
[build:L4:10s] npm info attempt registry request try #1 at 7:49:34 PM
[build:L5:10s] npm http request GET https://registry.npmjs.org/typescript
[build:L6:10s] npm http 200 https://registry.npmjs.org/typescript
[build:L7:30s] npm info lifecycle typescript@2.0.10~preinstall: typescript@2.0.10
*snip*
[build:L74:159s] 03 01 2017 19:52:03.632:DEBUG [karma]: A browser has connected on socket /#q9uzLB6RfLvoiS2JAAAA
[build:L75:159s] 03 01 2017 19:52:03.645:DEBUG [web-server]: upgrade /socket.io/?EIO=3&transport=websocket&sid=q9uzLB6RfLvoiS2JAAAA
[build:L76:159s] 03 01 2017 19:52:03.699:INFO [Chrome 53.0.2785 (Linux 0.0.0)]: Connected on socket /#q9uzLB6RfLvoiS2JAAAA with id 83595663
[build:L77:159s] 03 01 2017 19:52:03.701:DEBUG [launcher]: Nightmare (id 83595663) captured in 6.775 secs
[build:L78:159s] 03 01 2017 19:52:03.724:DEBUG [middleware:karma]: custom files null null
*snip*
                  ALERT: Error{}
[build:L109:161s] Chrome 53.0.2785 (Linux 0.0.0): Executed 4 of 17 SUCCESS (0 secs / 0.848 secs)
                  LOG: Error{}
[build:L112:161s] Chrome 53.0.2785 (Linux 0.0.0): Executed 4 of 17 SUCCESS (0 secs / 0.848 secs)
                  LOG: Object{}
[build:L115:161s] Chrome 53.0.2785 (Linux 0.0.0): Executed 4 of 17 SUCCESS (0 secs / 0.848 secs)
                  LOG: Object{}
[build:L119:161s] Chrome 53.0.2785 (Linux 0.0.0): Executed 5 of 17 SUCCESS (0 secs / 0.977 secs)
                  Chrome 53.0.2785 (Linux 0.0.0) EthereumService should create a connection to the locally running Ethereum client with address http://localhost:8545 FAILED
[build:L126:164s] 	Expected Error: CONNECTION ERROR: Couldn't connect to node http://localhost:8545. to be undefined.
[build:L127:164s] 	    at webpack:///drone/src/src/app/services/ethereum/ethereum.service.spec.ts:42:24 <- src/test.ts:63399:25
[build:L128:164s] 	    at ZoneDelegate.invoke (webpack:///drone/src/~/zone.js/dist/zone.js:192:0 <- src/test.ts:79451:28)
[build:L129:164s] 	    at AsyncTestZoneSpec.onInvoke (webpack:///drone/src/~/zone.js/dist/async-test.js:30:0 <- src/test.ts:49141:43)
[build:L130:164s] 	    at ProxyZoneSpec.onInvoke (webpack:///drone/src/~/zone.js/dist/proxy.js:57:0 <- src/test.ts:49738:43)
[build:L131:164s] 	    at ZoneDelegate.invoke (webpack:///drone/src/~/zone.js/dist/zone.js:191:0 <- src/test.ts:79450:34)
[build:L132:164s] Chrome 53.0.2785 (Linux 0.0.0): Executed 10 of 17 (1 FAILED) (0 secs / 3.495 secs)
*snip*
                  LOG: 'My IPFS node id is: ', 'QmY2inJB9ajsFEXDRvzZbjpewZtsnrfRQKgTAkHypNDBA3'
[build:L157:166s] Chrome 53.0.2785 (Linux 0.0.0): Executed 12 of 17 (2 FAILED) (0 secs / 5.6 secs)
                  LOG: 'My IPFS node id is: ', 'QmY2inJB9ajsFEXDRvzZbjpewZtsnrfRQKgTAkHypNDBA3'
[build:L161:168s] Chrome 53.0.2785 (Linux 0.0.0): Executed 13 of 17 (2 FAILED) (0 secs / 7.822 secs)
                  LOG: 'My IPFS node id is: ', 'QmY2inJB9ajsFEXDRvzZbjpewZtsnrfRQKgTAkHypNDBA3'
[build:L165:170s] Chrome 53.0.2785 (Linux 0.0.0): Executed 14 of 17 (2 FAILED) (0 secs / 9.874 secs)
                  Chrome 53.0.2785 (Linux 0.0.0): Executed 17 of 17 (2 FAILED) (12.354 secs / 12.242 secs)
[build:L171:172s] 03 01 2017 19:52:17.308:DEBUG [reporter.remap-istanbul]: Writing coverage to coverage
[build:L172:172s] 03 01 2017 19:52:17.318:DEBUG [reporter.remap-istanbul]: Writing coverage to ./coverage/coverage.lcov
[build:L173:173s] 03 01 2017 19:52:17.332:DEBUG [karma]: Run complete, exiting.
[build:L174:173s] 03 01 2017 19:52:17.334:DEBUG [launcher]: Disconnecting all browsers
[build:L175:174s] 03 01 2017 19:52:19.199:WARN [launcher]: Nightmare was not killed in 2000 ms, sending SIGKILL.
[build:L176:174s] 03 01 2017 19:52:19.202:DEBUG [launcher]: Process Nightmare exited with code 0
[build:L177:174s] 03 01 2017 19:52:19.203:DEBUG [temp-dir]: Cleaning temp dir /tmp/karma-83595663
[build:L178:174s] 03 01 2017 19:52:19.207:DEBUG [launcher]: Finished all browsers
[build] exit code 1
[ipfs:L15:177s]
[ipfs:L16:177s] Received interrupt signal, shutting down...
[ipfs:L17:177s] (Hit ctrl-c again to force-shutdown the daemon.)
build : exit code 1
```

### Installation

The service is started as a set of docker container.

```
version: '2'
services:
  drone-server:
    image: drone/drone:0.5
    hostname: drone-server
    container_name: drone-server
    ports:
     - 80:8000
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
     - /data/drone:/var/lib/drone
    environment:
     - DRONE_OPEN=true
     - DRONE_GITHUB=true
     - DRONE_GITHUB_CLIENT=8edc09a8b97f79d54091
     - DRONE_GITHUB_SECRET=3fdd0f9226dbe6ce6404f8b99dc611ac4d79c9e9
     - DRONE_SECRET=cp2017drone
    restart: always
    privileged: true

  drone-agent:
    image: drone/drone:0.5
    command: agent
    restart: always
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
    environment:
     - DRONE_SERVER=ws://ec2-54-194-144-141.eu-west-1.compute.amazonaws.com/ws/broker
     - DRONE_SECRET=cp2017drone

  aircover:
    image: aircover/aircover
    hostname: aircover
    container_name: aircover
    volumes:
     -  /var/lib/aircover:/var/lib/aircover
    env_file:
     - aircover.rc
    restart: always
    ports:
     - 8080:8000
```

The `dronerc` environment file contains:

```
DRONE_GITHUB=true
DRONE_GITHUB_CLIENT=<github_id>
DRONE_GITHUB_SECRET=<github_secret>
DRONE_SECRET=cp2017drone
DRONE_SERVER=ws://ec2-54-194-144-141.eu-west-1.compute.amazonaws.com/ws/broker
```
When created an `oauth` token pair, the callback URL is `http://ec2-54-194-144-141.eu-west-1.compute.amazonaws.com/authorize`.

The ENV file for aircover holds:

```
GITHUB_URL=https://github.com
GITHUB_SCOPE=user:email,read:org,repo
GITHUB_CLIENT=<github_id>
GITHUB_SECRET=<github_secret>
```
... in which the callback URL for aircover is suffixed with `/login`.
