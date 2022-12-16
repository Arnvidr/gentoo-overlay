# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Change this when you update the ebuild
GIT_COMMIT="5ceccf052b40658019923c2d456f91bafdab24a1"
EGO_PN="github.com/SoMuchForSubtlety/${PN}"

inherit golang-vcs-snapshot-r1

DESCRIPTION="TUI for F1TV"
HOMEPAGE="https://github.com/SoMuchForSubtlety/f1viewer"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug pie static"

DOCS=( README.md )

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

QA_PRESTRIPPED="usr/bin/.*"

src_compile() {
	export GOPATH="${G}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"
	(use static && ! use pie) && export CGO_ENABLED=0
	(use static && use pie) && CGO_LDFLAGS+=" -static"

	local myldflags=(
		"$(usex !debug '-s -w' '')"
		-X "main.version=v${PV}"
		-X "'main.date=$(date -u '+%FT%T%z')'"
	)

	local mygoargs=(
		-v -work -x
		-buildmode "$(usex pie pie exe)"
		-asmflags "all=-trimpath=${S}"
		-gcflags "all=-trimpath=${S}"
		-ldflags "${myldflags[*]}"
		-tags "$(usex static 'netgo' '')"
		-installsuffix "$(usex static 'netgo' '')"
		-o bin/f1viewer
	)

	go build "${mygoargs[@]}" main.go || die
}

src_install() {
	dobin bin/f1viewer
	use debug && dostrip -x /usr/bin/f1viewer
	einstalldocs
}
