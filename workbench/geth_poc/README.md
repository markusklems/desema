# Ethereum Testbed

An attempt to create a local ethereum network.

## Startup

A little startup script helps to get the order right.

### Wait for Consul and elasticsearch to come up

```
$ ./startup.sh
Creating consul
Creating elasticsearch
Creating kopf
> Waiting for consul to become accessible
x -> OK
> Waiting for elasticsearch service
XXXX
```
once this is done 

### restore snapshot and open kopf

```
> Waiting for elasticsearch service
XXXXXXXXXXX -> OK
> register snapshot mount
true
> restore snapshot_0
true
> Create logstash index
true
> Set kibana replicas to 0
true
> Open Kopf dashboard
```

### start logstash and wait for for 5 sec

```
> Start logstash and kibana
consul is up-to-date
Creating logstash
Creating kibana
```

### Start the bootnode and open kibana dashboard

```
> Start the bootnode
consul is up-to-date
Creating bootnode
> Open kibana dashboard to check the log of the bootnode
```

### start a geth-client

```
> start geth-client
consul is up-to-date
bootnode is up-to-date
elasticsearch is up-to-date
kopf is up-to-date
kibana is up-to-date
logstash is up-to-date
Creating docker_geth_1
```