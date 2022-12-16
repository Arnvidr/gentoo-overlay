EAPI=7

inherit autotools xdg

DESCRIPTION="A set of plugins for digital audio workstations"
HOMEPAGE="https://launchpad.net/invada-studio"

SRC_URI="https://launchpad.net/invada-studio/ladspa/0.3/+download/invada-studio-plugins_0.3.1-nopkg.tar.gz -> ${P}.tar.gz"
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

src_install() {
	sed -i 's:/usr/local:${D}/usr/local:g' Makefile
	default
}
