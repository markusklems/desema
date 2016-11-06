package source_test

import (
	"fmt"

	"github.com/ChristianKniep/cp2017/workbench/apiPoc/source/lib"
)

func ReadFileTest() {
	in := source.ReadFile("../input.json")
	fmt.Println(in)
	// Output: {[1 2 3 4 5 6]}
}
