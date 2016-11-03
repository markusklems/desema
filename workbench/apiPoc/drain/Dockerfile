FROM qnib/alpn-go-dev

ENV HTTP_PORT=8080

ADD main.go /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/drain/

ADD input.json /data/
RUN cd /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/drain/ \
 && go get -d \
 && go build -o /usr/local/bin/drain

CMD ["/usr/local/bin/drain"]
