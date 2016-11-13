FROM ubuntu:16.04
MAINTAINER "Christian Kniep <christian@qnib.org>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 923F6CA9 \
 && echo "deb http://ppa.launchpad.net/ethereum/ethereum/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/ethereum.list  \
 && apt-get update
RUN apt install -qy bootnode
RUN mkdir -p /data/ \
 && bootnode --genkey=/data/boot.key
ADD start.sh /
CMD ["/start.sh"]
