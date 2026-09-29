# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Change this when you update the ebuild
GIT_COMMIT="53be77a2e0be812f85822df0fd9a9c28fcc3242b"
#EGO_PN="github.com/wtfutil/${PN}"
EGO_PN="github.com/wtfutil/wtf"

inherit go-module

DESCRIPTION="The personal information dashboard for your terminal"
HOMEPAGE="https://github.com/wtfutil/wtf"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/wtf-${PV}"

QA_PRESTRIPPED="usr/bin/.*"

BDEPEND=">=dev-lang/go-1.26.4:="

src_compile() {
	export GOPATH="${S}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	local myldflags=(
		"-s -w"
		-X "main.version=v${PV}-${GIT_COMMIT:0:6}"
		-X "'main.date=$(date -u '+%FT%T%z')'"
	)

	local mygoargs=(
		-ldflags "${myldflags[*]}"
		-o bin/tessera
	)

	ego build "${mygoargs[@]}"
}

src_install() {
	dobin bin/tessera
	dodoc README.md
}

pkg_postinst() {
	einfo
	elog "See https://wtfutil.com/configuration/files/ for configuration guide"
	einfo
}
