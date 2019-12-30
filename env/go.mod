module github.com/kamilsk/dotfiles

go 1.11

require (
	github.com/golang/mock v1.3.1
	github.com/golangci/golangci-lint v1.21.0
	github.com/goreleaser/godownloader v0.1.0
	github.com/goreleaser/goreleaser v0.118.2
	github.com/kamilsk/egg v0.0.2
	golang.org/x/tools v0.2.2
)

// goimports: https://github.com/kamilsk/go-tools/releases/tag/goimports
replace golang.org/x/tools => github.com/kamilsk/go-tools v0.0.1

// egg: https://github.com/izumin5210/gex/compare/master...kamilsk:extended
replace github.com/izumin5210/gex => github.com/kamilsk/gex v0.6.0-e1

// godownloader: https://github.com/golangci/golangci-lint/issues/730
replace github.com/go-macaron/cors v0.0.0-20190309005821-6fd6a9bfe14e9 => github.com/go-macaron/cors v0.0.0-20190418220122-6fd6a9bfe14e
