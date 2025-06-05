# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit edo python-single-r1 xdg

DESCRIPTION="A simple GOG client for Linux"
HOMEPAGE="https://github.com/sharkwouter/minigalaxy"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sharkwouter/minigalaxy.git"
else
	SRC_URI="https://github.com/sharkwouter/${PN}/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE="system-dosbox system-scummvm"
# Slotted webkit-gtk to keep the same version as lutris, and avoid multiple slots
DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=net-libs/webkit-gtk-2.6:4.1
	>=x11-libs/gtk+-3
"
RDEPEND="${DEPEND}
	system-dosbox? ( games-emulation/dosbox )
	system-scummvm? ( games-engines/scummvm )
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( "${FILESDIR}/${PN}-paths.patch" )

src_install() {
	# workaround for legacy setup.py
	edo ${EPYTHON} setup.py install --root="${D}" --prefix="${EPREFIX}/usr" --optimize=1
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postinst
}
