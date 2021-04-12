package env

import (
	"fmt"
	"path/filepath"
	"strings"

	"github.com/google/go-github/v35/github"
)

func SetUp(list []*github.Repository, dry bool) error {
	if dry {
		fmt.Println("newdir ~/Development")
		for _, repo := range list {
			dst := strings.ReplaceAll(repo.GetFullName(), "/.", "/")
			scope := "public"
			if repo.GetPrivate() {
				scope = "private"
			}
			dst = filepath.Join(scope, dst)

			fmt.Println("mkdir -p", dst)
			fmt.Println("git clone", repo.GetSSHURL(), dst, "|| true")
		}
	}
	return nil
}
