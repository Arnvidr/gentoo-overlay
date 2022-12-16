# Copyright 2020
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DESCRIPTION="Steam Play compatibility tool to run DOS games using native Linux DOSBox"
HOMEPAGE="https://github.com/dreamer/boxtron"
SRC_URI="https://github.com/dreamer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="|| ( games-emulation/dosbox games-emulation/dosbox-staging )
	sys-fs/inotify-tools
	media-sound/timidity++
	media-sound/fluid-soundfont"
RDEPEND="${DEPEND}"
BDEPEND=""
#dev-util/shellcheck
#dev-python/pylint"

src_compile() {
	echo "No compilation"
}
