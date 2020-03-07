module github.com/kamilsk/dotfiles/legacy

go 1.11

require github.com/goreleaser/godownloader v0.1.0

// godownloader: https://github.com/golangci/golangci-lint/issues/730
replace github.com/go-macaron/cors v0.0.0-20190309005821-6fd6a9bfe14e9 => github.com/go-macaron/cors v0.0.0-20190418220122-6fd6a9bfe14e
