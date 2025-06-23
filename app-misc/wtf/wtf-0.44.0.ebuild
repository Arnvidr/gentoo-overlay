# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Change this when you update the ebuild
GIT_COMMIT="c2e1809bb60cfcd51957585166bb70bb123d3ee6"
EGO_PN="github.com/wtfutil/${PN}"

inherit go-module

DESCRIPTION="The personal information dashboard for your terminal"
HOMEPAGE="https://github.com/wtfutil/wtf"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

QA_PRESTRIPPED="usr/bin/.*"

src_compile() {
	export GOPATH="${G}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	local myldflags=(
		"-s -w"
		-X "main.version=v${PV}-${GIT_COMMIT:0:6}"
		-X "'main.date=$(date -u '+%FT%T%z')'"
	)

	local mygoargs=(
		-ldflags "${myldflags[*]}"
		-o bin/wtfutil
	)

	ego build "${mygoargs[@]}"
}

src_install() {
	dobin bin/wtfutil
	dodoc README.md
}

pkg_postinst() {
	einfo
	elog "See https://wtfutil.com/configuration/files/ for configuration guide"
	einfo
}
