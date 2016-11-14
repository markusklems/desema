#!/bin/bash

function wait_consul {
    echo -n "x"
    docker run --rm -t --network=host qnib/consul-cli kv keys / >/dev/null
    if [ $? -ne 0 ];then
        echo -n "x"
        sleep 1
        wait_consul
    else
        echo " -> OK "
    fi
}
function wait_consul_srv {
    echo -n "X"
    if [ $(docker run -t --network=host qnib/consul-cli health service ${1} --passing |jq '. |length') -eq 0 ];then
        echo -n "X"
        sleep 1
        wait_consul_srv ${1}
    else
        echo " -> OK "
    fi
}

docker-compose up -d consul elasticsearch kopf

echo "> Waiting for consul to become accessible"
wait_consul
echo "> Waiting for elasticsearch service"
wait_consul_srv elasticsearch

echo "> register snapshot mount"
curl -sXPUT 'http://localhost:9200/_snapshot/my_backup' -d @elasticsearch/snapshot/create_snap.json |jq '.acknowledged'
echo "> restore snapshot_0"
curl -sXPOST "localhost:9200/_snapshot/my_backup/snapshot_0/_restore" |jq '.accepted'
echo "> Create logstash index"
curl -sXPUT localhost:9200/logstash-$(date +'%Y.%m.%d')/ -d '{"settings": {"index" : {"number_of_replicas" : 0}}}' |jq '.acknowledged'
echo "> Set kibana replicas to 0"
curl -sXPUT "localhost:9200/.kibana/_settings" -d '{"index" : {"number_of_replicas" : 0}}' |jq '.acknowledged'

echo "> Open Kopf dashboard"
open http://localhost:80 &

echo "> Start logstash and kibana"
docker-compose up -d kibana logstash
sleep 10
echo "> Start the bootnode"
docker-compose up -d bootnode
sleep 6
echo "> Open kibana dashboard to check the log of the bootnode"
open http://localhost:5601/app/kibana#/dashboard/SimpleDash
echo "> start geth-client and miner"
docker-compose up -d
