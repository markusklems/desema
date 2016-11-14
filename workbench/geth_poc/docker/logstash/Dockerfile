FROM logstash

RUN apt-get update \
 && apt-get install -y curl tar \
 && curl -fsL https://github.com/CiscoCloud/consul-cli/releases/download/v0.3.1/consul-cli_0.3.1_linux_amd64.tar.gz |tar xfz - -C /usr/local/bin/ --strip-components=1
COPY etc/logstash.conf /etc/logstash/
COPY etc/conf.d/patterns.conf /etc/logstash/conf.d/
CMD ["-f", "/etc/logstash/logstash.conf", "-r"]
