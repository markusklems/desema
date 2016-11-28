#!/bin/bash

#geth --rpc --rpccorsdomain "http://0.0.0.0:4200"
geth --rpc --rpccorsdomain "*" --rpcaddr 0.0.0.0 --rpcapi eth0,lo
