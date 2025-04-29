# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Razer devices configurator"
HOMEPAGE="https://github.com/z3ntu/RazerGenie"
SRC_URI="https://github.com/z3ntu/RazerGenie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="experimental matrix"

DEPEND="dev-python/pyqt6[dbus,network,widgets,xml]"
RDEPEND="${DEPEND}
	sys-apps/openrazer"

#dev-qt/linguist-tools:5
BDEPEND="virtual/pkgconfig"

src_configure() {
	cmake -G ninja
	ninja
}
