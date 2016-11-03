FROM qnib/alpn-go-dev

ADD main.go /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/microservice/
WORKDIR /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/microservice/
RUN go get -d \
 && go build -o /usr/local/bin/microservice

CMD ["/usr/local/bin/microservice"]
