FROM ubuntu:wily  

MAINTAINER Ahmed Tidjani Tidjani

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get upgrade -q -y && \
    apt-get dist-upgrade -q -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get install -q -y ethereum

RUN mkdir -p ~/blockchain
COPY db ~/blockchain/
COPY CustomGenesis.json ~/blockchain/

EXPOSE 8545 
EXPOSE 30303 
ENTRYPOINT ["/usr/bin/geth","--datadir","~/blockchain/db","--nodiscover","--port","30303","--maxpeers","0","--rpc","--rpcaddr","0,0,0,0","--rpcport","8545","--rpccorsdomain","*"]
CMD ["console"]
