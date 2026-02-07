EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="The free-forever Python Simple GUI software"
HOMEPAGE="https://github.com/spyoungtech/FreeSimpleGUI"
SRC_URI="https://github.com/spyoungtech/FreeSimpleGUI/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S=${WORKDIR}/${PN}-${P}

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

