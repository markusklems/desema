package main

import (
	"flag"
	"os"
	"strconv"

	"github.com/ChristianKniep/cp2017/workbench/apiPoc/source/lib"
)

func main() {
	httpPort, _ := strconv.Atoi(os.Getenv("HTTP_PORT"))
	var filePath string
	flag.StringVar(&filePath, "input-file", "/data/input.json", "JSON file to parse as input")
	flag.Parse()
	source.RunAPI(filePath, httpPort)
}
