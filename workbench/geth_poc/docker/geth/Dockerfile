FROM ubuntu:16.04
MAINTAINER "Christian Kniep <christian@qnib.org>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 923F6CA9 \
 && echo "deb http://ppa.launchpad.net/ethereum/ethereum/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/ethereum.list  \
 && apt-get update
RUN apt install -qy geth bind9-host curl tar \
 && curl -fsL https://github.com/CiscoCloud/consul-cli/releases/download/v0.3.1/consul-cli_0.3.1_linux_amd64.tar.gz |tar xfz - -C /usr/local/bin/ --strip-components=1

ENV TERM=xterm
ADD genesis.json /opt/
RUN geth init opt/genesis.json
ADD start.sh /opt/
CMD ["/opt/start.sh"]
