FROM qnib/alpn-go-dev

ENV HTTP_PORT=8080

ADD main.go /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/source/

ADD input.json /data/
RUN cd /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/source/ \
 && go get -d \
 && go build -o /usr/local/bin/source

CMD ["/usr/local/bin/source"]
