package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"

	"github.com/rs/cors"
)

type input struct {
	Value []int `json:"value"`
}

func readFile(path string) input {
	file, e := ioutil.ReadFile(path)
	if e != nil {
		fmt.Printf("File error: %v\n", e)
		os.Exit(1)
	}
	var in input
	json.Unmarshal(file, &in)
	return in
}

func main() {
	httpPort, _ := strconv.Atoi(os.Getenv("HTTP_PORT"))
	var filePath string
	flag.StringVar(&filePath, "input-file", "/data/input.json", "JSON file to parse as input")
	flag.Parse()
	in := readFile(filePath)
	inMarshalled, err := json.Marshal(in)
	if err != nil {
		fmt.Printf("Marshal error: %v\n", err)
		os.Exit(1)
	}
	mux := http.NewServeMux()
	mux.HandleFunc("/get", func(w http.ResponseWriter, req *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte(string(inMarshalled)))
	})

	handler := cors.Default().Handler(mux)
	http.ListenAndServe(fmt.Sprintf(":%d", httpPort), handler)
}
