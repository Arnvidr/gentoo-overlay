# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8
inherit cmake toolchain-funcs multilib

DESCRIPTION="LV2 audio plugin bundle"
HOMEPAGE="http://eq10q.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/eq10q/files/latest/download -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="
	dev-cpp/gtkmm:2.4
	>=sci-libs/fftw-3.3.4
	|| ( media-libs/lv2 media-libs/lv2core )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

src_configure() {
	PREFIX=/usr/lib/lv2

	cmake_src_configure
}

src_compile() {
	cd ${BUILD_DIR}

	cmake_src_compile
}

src_install() {
	cd ${BUILD_DIR}

	cmake_src_install
}
