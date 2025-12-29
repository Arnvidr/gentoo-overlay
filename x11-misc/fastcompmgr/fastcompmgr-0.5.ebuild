# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

XORG_MODULE=app/
inherit xorg-3

DESCRIPTION="X Compositing manager (fork of xcompmgr)" 
HOMEPAGE="https://github.com/tycho-kirchner/fastcompmgr"
SRC_URI="https://github.com/tycho-kirchner/fastcompmgr/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0 MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXcomposite
	x11-libs/libXext
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"

src_configure() {
	debug-print-function ${FUNCNAME} "$@"
}

src_install() {
	emake PREFIX="${D}" DESTDIR="${D}" install
}
