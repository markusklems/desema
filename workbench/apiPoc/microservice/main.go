package main

import (
	"net/http"

	"github.com/rs/cors"
)

// RegBody parses the request of /add
type RegBody struct {
	Value int
}

// LastJob stores the last job done by the API
type LastJob struct {
	LastIn  []int `json:"last_in"`
	LastOut int   `json:"last_out"`
}

func main() {
	mux := http.NewServeMux()
	// function that is handle by the microservice in the end
	mux.HandleFunc("/status", func(w http.ResponseWriter, req *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte("{\"last_in\": [1,2,3,4], \"last_out\": 10}"))
	})
	handler := cors.Default().Handler(mux)
	http.ListenAndServe(":8081", handler)
}
