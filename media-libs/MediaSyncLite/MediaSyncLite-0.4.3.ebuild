EAPI=8

DESCRIPTION="MediaSync Lite for Linux"
HOMEPAGE="https://github.com/iBroadcastMediaServices/MediaSyncLiteLinux"
SRC_URI="https://github.com/iBroadcastMediaServices/MediaSyncLiteLinux/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}Linux-${PV}"
