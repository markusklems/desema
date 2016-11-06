package source

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/rs/cors"
)

type input struct {
	Value []int `json:"value"`
}

func ReadFile(path string) input {
	file, e := ioutil.ReadFile(path)
	if e != nil {
		fmt.Printf("File error: %v\n", e)
		os.Exit(1)
	}
	var in input
	json.Unmarshal(file, &in)
	return in
}

// RunAPI Listen on httpPort to serve filePath
func RunAPI(filePath string, httpPort int) {
	in := ReadFile(filePath)
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
