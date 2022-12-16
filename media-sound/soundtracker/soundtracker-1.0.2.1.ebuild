# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit xdg-utils

DESCRIPTION="Pattern-oriented music editor"
HOMEPAGE="https://sourceforge.net/projects/soundtracker/"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	default_src_install
	mv "${D}/usr/share/appdata" "${D}/usr/share/metainfo" || die
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
