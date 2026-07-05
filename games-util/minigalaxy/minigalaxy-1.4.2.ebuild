# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit desktop python-single-r1 xdg

DESCRIPTION="A simple GOG client for Linux"
HOMEPAGE="https://github.com/sharkwouter/minigalaxy"
SRC_URI="https://github.com/sharkwouter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="system-dosbox system-scummvm system-wine"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Slotted webkit-gtk to keep the same version as lutris, and avoid multiple slots
DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	app-arch/unzip
	>=net-libs/webkit-gtk-2.6:4.1[introspection]
	>=x11-libs/gtk+-3[introspection]
	x11-libs/gdk-pixbuf[introspection,jpeg]
	x11-libs/libnotify[introspection]
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}
	system-dosbox? ( games-emulation/dosbox-staging )
	system-scummvm? ( games-engines/scummvm )
	system-wine? ( virtual/wine )
"
BDEPEND="
	${PYTHON_DEPS}
	sys-apps/help2man
	sys-devel/gettext
"

src_prepare() {
	sed -e "s:os.path.dirname(sys.argv\[0\]):'${EPREFIX}/usr/share/':" \
		-e "s:minigalaxy/translations:locale:" \
		-i minigalaxy/paths.py || die
	default
}

src_compile() {
	help2man -N -s 6 -n "a simple GTK-based GOG Linux client" bin/minigalaxy > minigalaxy.6 || die
	lo_files=( data/po/*.po )
	local lo
	for lo in "${lo_files[@]%.po}"; do
		msgfmt "${lo}.po" -o "${lo}.mo" || die
	done
}

src_install() {
	insinto /usr/share/minigalaxy
	doins -r data/images data/ui data/style.css
	insinto /usr/share/metainfo
	doins data/io.github.sharkwouter.Minigalaxy.metainfo.xml

	doman minigalaxy.6
	domo "${lo_files[@]/%.po/.mo}"
	unset lo_files

	local x
	for x in 128 192; do
		doicon -s ${x} data/icons/${x}x${x}/io.github.sharkwouter.Minigalaxy.png
	done

	domenu data/io.github.sharkwouter.Minigalaxy.desktop

	dodoc README.md CHANGELOG.md

	python_domodule minigalaxy
	python_doscript bin/minigalaxy
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postinst
}
