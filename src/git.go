package main

import (
	"context"
	"flag"
	"os"

	"golang.org/x/oauth2"

	"go.octolab.org/sandbox/git/internal/env"
	"go.octolab.org/sandbox/git/internal/service/github"
)

var dry = flag.Bool("dry-run", false, "print bash scripts instead of execute them")

func main() {
	flag.Parse()

	ctx := context.Background()
	source := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: os.Getenv("GITHUB_TOKEN")},
	)
	client := oauth2.NewClient(ctx, source)

	service, err := github.New(client)
	if err != nil {
		panic(err)
	}

	list, err := service.Repositories(ctx)
	if err != nil {
		panic(err)
	}

	if err := env.SetUp(list, *dry); err != nil {
		panic(err)
	}
}
