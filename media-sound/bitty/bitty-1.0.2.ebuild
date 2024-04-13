# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Bitty admin program"
HOMEPAGE="https://www.curioussoundobjects.com/"
SRC_URI="Bitty_1.0.2_amd64.deb"

S="${WORKDIR}"

SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror fetch strip"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	mv "${S}/usr/share/doc/${PN}" "${S}/usr/share/doc/${P}"

	cp -r . "${ED}" || die

	dosym -r "/opt/Bitty/${PN}" "/usr/bin/${PN}"
}

pkg_postinst() {
        xdg_icon_cache_update
}

pkg_postrm() {
        xdg_icon_cache_update
}

