package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/rs/cors"
)

// RegBody parses the request of /add
type RegBody struct {
	Value int
}

func main() {
	httpPort, _ := strconv.Atoi(os.Getenv("HTTP_PORT"))
	flag.Parse()
	mux := http.NewServeMux()
	mux.HandleFunc("/add", func(w http.ResponseWriter, req *http.Request) {
		decoder := json.NewDecoder(req.Body)
		var b RegBody
		err := decoder.Decode(&b)
		if err != nil {
			fmt.Println(err)
		}
		fmt.Println(b.Value)
		w.Write([]byte(fmt.Sprintf("{\"value\": %d}", b.Value)))
	})

	handler := cors.Default().Handler(mux)
	http.ListenAndServe(fmt.Sprintf(":%d", httpPort), handler)
}
