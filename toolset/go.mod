module github.com/kamilsk/dotfiles

go 1.19

require (
	github.com/adonovan/spaghetti v0.0.0-20210409171412-ba438b8fd619 // ?
	github.com/cube2222/octosql v0.9.2
	github.com/ericchiang/pup v0.4.0
	github.com/evanw/esbuild v0.15.3
	github.com/golang/mock v1.6.0
	github.com/isacikgoz/gia v0.2.0
	github.com/itchyny/gojq v0.12.8
	github.com/kyoh86/git-vertag v1.2.1-0.20201114131231-e69f8de182bb // https://github.com/kyoh86/git-vertag/issues/14
	github.com/marwan-at-work/mod v0.4.2
	github.com/mikefarah/yq/v4 v4.27.2
	github.com/mrnugget/fzz v1.1.0
	golang.org/x/exp v0.0.0-20220722155223-a9213eeb770e // ?
	golang.org/x/tools v0.1.12
	mvdan.cc/gofumpt v0.3.1
)

replace golang.org/x/tools v0.1.12 => github.com/kamilsk/go-tools v0.1.12

// https://github.com/kamilsk/dotfiles/issues/312
replace github.com/segmentio/parquet-go v0.0.0-20220421002521-93f8e5ed3407 => github.com/cube2222/parquet-go v0.0.0-20220512155810-0e06eee50261

require (
	github.com/Masterminds/semver v1.5.0 // indirect
	github.com/PuerkitoBio/goquery v1.5.1 // indirect
	github.com/a8m/envsubst v1.3.0 // indirect
	github.com/alecthomas/kingpin v2.2.6+incompatible // indirect
	github.com/alecthomas/participle/v2 v2.0.0-beta.4 // indirect
	github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751 // indirect
	github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d // indirect
	github.com/andybalholm/brotli v1.0.3 // indirect
	github.com/andybalholm/cascadia v1.1.0 // indirect
	github.com/awalterschulze/gographviz v2.0.3+incompatible // indirect
	github.com/blang/semver v3.5.1+incompatible // indirect
	github.com/cespare/xxhash v1.1.0 // indirect
	github.com/cpuguy83/go-md2man/v2 v2.0.2 // indirect
	github.com/dgraph-io/ristretto v0.0.3 // indirect
	github.com/dsnet/compress v0.0.1 // indirect
	github.com/elliotchance/orderedmap v1.4.0 // indirect
	github.com/fatih/color v1.13.0 // indirect
	github.com/fsnotify/fsnotify v1.5.1 // indirect
	github.com/goccy/go-json v0.9.10 // indirect
	github.com/goccy/go-yaml v1.9.5 // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/google/btree v1.1.2 // indirect
	github.com/google/go-cmp v0.5.8 // indirect
	github.com/google/go-github v17.0.0+incompatible // indirect
	github.com/google/go-querystring v0.0.0-20170111101155-53e6ce116135 // indirect
	github.com/google/uuid v1.3.0 // indirect
	github.com/gosuri/uilive v0.0.4 // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/itchyny/timefmt-go v0.1.3 // indirect
	github.com/jackc/pgx v3.6.2+incompatible // indirect
	github.com/jinzhu/copier v0.3.5 // indirect
	github.com/jroimartin/gocui v0.4.0 // indirect
	github.com/klauspost/compress v1.15.9 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/lib/pq v1.10.6 // indirect
	github.com/magiconair/properties v1.8.6 // indirect
	github.com/mattn/go-colorable v0.1.12 // indirect
	github.com/mattn/go-isatty v0.0.14 // indirect
	github.com/mattn/go-runewidth v0.0.13 // indirect
	github.com/mholt/archiver v3.1.1+incompatible // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/nsf/termbox-go v0.0.0-20190325093121-288510b9734e // indirect
	github.com/nwaples/rardecode v1.1.2 // indirect
	github.com/nxadm/tail v1.4.8 // indirect
	github.com/oklog/ulid/v2 v2.0.2 // indirect
	github.com/olekukonko/tablewriter v0.0.5 // indirect
	github.com/pierrec/lz4 v2.6.1+incompatible // indirect
	github.com/pierrec/lz4/v4 v4.1.15 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pkg/profile v1.6.0 // indirect
	github.com/rivo/uniseg v0.2.0 // indirect
	github.com/russross/blackfriday/v2 v2.1.0 // indirect
	github.com/segmentio/encoding v0.3.5 // indirect
	github.com/segmentio/parquet-go v0.0.0-20220421002521-93f8e5ed3407 // indirect
	github.com/shopspring/decimal v1.3.1 // indirect
	github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966 // indirect
	github.com/spaolacci/murmur3 v1.1.0 // indirect
	github.com/spf13/cobra v1.5.0 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	github.com/stretchr/testify v1.7.5 // indirect
	github.com/tidwall/btree v1.3.1 // indirect
	github.com/ulikunitz/xz v0.5.10 // indirect
	github.com/urfave/cli/v2 v2.3.0 // indirect
	github.com/valyala/fastjson v1.6.3 // indirect
	github.com/waigani/diffparser v0.0.0-20190426062500-1f7065f429b5 // indirect
	github.com/xi2/xz v0.0.0-20171230120015-48954b6210f8 // indirect
	golang.org/x/crypto v0.0.0-20220722155217-630584e8d5aa // indirect
	golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4 // indirect
	golang.org/x/net v0.0.0-20220722155237-a158d28d115b // indirect
	golang.org/x/oauth2 v0.0.0-20220722155238-128564f6959c // indirect
	golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4 // indirect
	golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f // indirect
	golang.org/x/text v0.3.7 // indirect
	golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20220722212130-b98a9ff5e252 // indirect
	google.golang.org/grpc v1.48.0 // indirect
	google.golang.org/protobuf v1.28.0 // indirect
	gopkg.in/op/go-logging.v1 v1.0.0-20160211212156-b2cb9fa56473 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
