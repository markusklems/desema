#!/bin/bash

function read_kv {
    VAL=$(consul-cli --consul=consul:8500 kv read bootnode/${1})
    if [ "X${VAL}" == "X" ];then
        sleep 1
        read_kv ${1}
    else
        echo ${VAL}
    fi
}
ENODE_ID=$(read_kv enode)
ENODE_PORT=$(read_kv port)
ENODE_HOST=$(read_kv host)

if [ "X${ET_MINE_ACCOUNT}" != "X" ];then
    GETH_OPTS="--mine --minerthreads=1 --etherbase=${ET_MINE_ACCOUNT}"
fi

geth --bootnodes=enode://${ENODE_ID}@$(host -t A bootnode |awk '{print $NF}'):30301 $(echo ${GETH_OPTS} | tr -d '"')
