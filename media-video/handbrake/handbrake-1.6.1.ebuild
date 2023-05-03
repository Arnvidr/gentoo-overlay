# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit autotools python-any-r1 toolchain-funcs xdg

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/HandBrake/HandBrake.git"
	inherit git-r3
	KEYWORDS=""
else
	MY_P="HandBrake-${PV}"
	SRC_URI="https://download.handbrake.fr/releases/${PV}/${MY_P}-source.tar.bz2"
	SRC_URI="https://github.com/HandBrake/HandBrake/releases/download/${PV}/${MY_P}-source.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Open-source, GPL-licensed, multiplatform, multithreaded video transcoder"
HOMEPAGE="http://handbrake.fr/"
LICENSE="GPL-2"

SLOT="0"
IUSE="+fdk gstreamer gtk numa x265"

RDEPEND="
	app-arch/xz-utils
	dev-libs/fribidi
	dev-libs/jansson:=
	dev-libs/libxml2
	media-libs/a52dec
	>=media-libs/dav1d-1.0.0:=
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libass:=
	>=media-libs/libbluray-1.3.4:=
	media-libs/libdvdnav
	media-libs/libdvdread:=
	media-libs/libjpeg-turbo:=
	media-libs/libmkv
	media-libs/libogg
	media-libs/libtheora
	media-libs/libvorbis
	>=media-libs/libvpx-1.12.0:=
	media-libs/opus
	media-libs/speex
	>=media-libs/svt-av1-1.4.1
	media-libs/x264:=
	media-libs/zimg
	media-sound/lame
	>=media-video/ffmpeg-5.1.2:0=[postproc,fdk?]
	sys-libs/zlib
	fdk? ( media-libs/fdk-aac:= )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
		media-libs/gst-plugins-bad:1.0
		media-libs/gst-plugins-ugly:1.0
		media-plugins/gst-plugins-a52dec:1.0
		media-plugins/gst-plugins-libav:1.0
		media-plugins/gst-plugins-x264:1.0
		media-plugins/gst-plugins-gdkpixbuf:1.0
	)
	gtk? (
		>=x11-libs/gtk+-3.10
		dev-libs/dbus-glib
		dev-libs/glib:2
		dev-libs/libgudev:=
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/libnotify
		x11-libs/pango
	)
	x265? ( >=media-libs/x265-3.2:0=[10bit,12bit,numa?] )
	"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-lang/yasm
	dev-util/intltool
"

# Patches for 1.6.1 not checked yet because of masked ffmpeg 5
#PATCHES=(
	# Fix missing flags
#	"${FILESDIR}/${P}-missing-linker-flags.patch"
#	"${FILESDIR}/${P}-missing-linker-flags-cli.patch"
#	"${FILESDIR}/${P}-missing-linker-flags-test.patch"
#	"${FILESDIR}/${P}-ignore-autoconf-check.patch"
#	"${FILESDIR}/${P}-ffmpeg-5.0.patch"
#)

src_prepare() {
	default

	cd "${S}/gtk" || die
	eautoreconf
}

src_configure() {
	tc-export AR RANLIB STRIP

	./configure \
		--force \
		--verbose \
		--prefix="${EPREFIX}/usr" \
		--disable-gtk-update-checks \
		--disable-flatpak \
		--enable-ffmpeg-aac \
		$(usex fdk --enable-fdk-aac) \
		$(usex !gtk --disable-gtk) \
		$(usex !gstreamer --disable-gst) \
		$(use_enable numa) \
		$(use_enable x265) || die "Configure failed."
}

src_compile() {
	emake -C build
}

src_install() {
	emake -C build DESTDIR="${D}" install

	dodoc {README,AUTHORS,NEWS,THANKS}.markdown
}

pkg_postinst() {
	einfo "For the CLI version of HandBrake, you can use \`HandBrakeCLI\`."

	if use gtk ; then
		einfo ""
		einfo "For the GTK+ version of HandBrake, you can run \`ghb\`."
	fi

	xdg_pkg_postinst
}
