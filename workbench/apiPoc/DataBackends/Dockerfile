FROM qnib/alpn-go-dev

ADD main.go /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/InOut/
WORKDIR /usr/local/src/github.com/ChristianKniep/cp2017/workbench/apiPoc/InOut/
RUN go get -d \
 && go build -o /usr/local/bin/inout

CMD ["/usr/local/bin/inout"]
