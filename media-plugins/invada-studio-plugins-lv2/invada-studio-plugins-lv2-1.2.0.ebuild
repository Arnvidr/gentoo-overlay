EAPI=7

inherit autotools xdg

DESCRIPTION="A set of LV2 plugins for digital audio workstations"
HOMEPAGE="https://launchpad.net/invada-studio/lv2"

SRC_URI="https://launchpad.net/invada-studio/lv2/1.2/+download/invada-studio-plugins-lv2_1.2.0-nopkg.tgz -> ${P}.tgz"
KEYWORDS="amd64 x86"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	gnome-base/libglade
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
	virtual/jack
	media-libs/lv2
"
RDEPEND="${DEPEND}"

src_prepare() {
	patch -d "${D}" -p1 < "${FILESDIR}"/invada-studio-fixes.patch
	default
}

src_install() {
	sed -i 's:/usr/local:${D}/usr/local:g' Makefile
	default
	make install-sys
}
