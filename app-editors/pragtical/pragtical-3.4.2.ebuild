# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="The practical and pragmatic code editor"
HOMEPAGE="https://pragtical.dev/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/lua:5.4
	media-libs/freetype
	media-libs/libsdl2
"
RDEPEND="${DEPEND}"

EMESON_BUILDTYPE=release

src_configure() {
	local emesonargs=( --wrap-mode default -Duse_system_lua=true )
	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
