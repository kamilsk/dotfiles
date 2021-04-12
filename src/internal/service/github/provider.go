package github

import (
	"context"
	"net/http"

	"github.com/google/go-github/v35/github"
)

func New(client *http.Client) (*service, error) {
	return &service{
		client: github.NewClient(client),
	}, nil
}

type service struct {
	client *github.Client
}

func (srv *service) Repositories(ctx context.Context) ([]*github.Repository, error) {
	var (
		cycle  = new(github.Response)
		result []*github.Repository
	)
	cycle.NextPage = 1

	for cycle.NextPage != 0 {
		opt := &github.RepositoryListOptions{
			Affiliation: "owner,organization_member",
			Visibility:  "all",
			ListOptions: github.ListOptions{
				Page:    cycle.NextPage,
				PerPage: 100,
			},
		}
		list, call, err := srv.client.Repositories.List(ctx, "", opt)
		if err != nil {
			return nil, err
		}
		cycle = call
		result = append(result, filterByPermission(list)...)
	}

	return result, nil
}

func filterByPermission(input []*github.Repository) []*github.Repository {
	filtered := input[:0]
	for _, repo := range input {
		if repo.GetPermissions()["admin"] {
			filtered = append(filtered, repo)
		}
	}
	return filtered
}
