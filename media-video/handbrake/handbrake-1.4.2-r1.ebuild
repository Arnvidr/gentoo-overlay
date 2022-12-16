# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit autotools eutils gnome2-utils python-any-r1 xdg-utils

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
	dev-libs/jansson
	dev-libs/libxml2
	media-libs/a52dec
	>=media-libs/dav1d-0.9.0
	media-libs/libass:=
	>=media-libs/libbluray-1.3.0
	media-libs/libdvdnav
	media-libs/libdvdread:=
	media-libs/libjpeg-turbo
	media-libs/libmkv
	media-libs/libtheora
	media-libs/libvorbis
	>=media-libs/libvpx-1.10.0
	media-libs/opus
	media-libs/speex
	media-libs/x264:=
	media-libs/zimg
	media-sound/lame
	sys-libs/zlib
	>=media-video/ffmpeg-4.4:0=[fdk?]
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
	fdk? ( media-libs/fdk-aac )
	x265? ( media-libs/x265:0=[10bit,12bit,numa?] )
	"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-lang/yasm
	dev-util/intltool
	sys-devel/automake"

PATCHES=(
	# Fix missing flags
	"${FILESDIR}/${P}-missing-linker-flags.patch"
	"${FILESDIR}/${P}-missing-linker-flags-cli.patch"
	"${FILESDIR}/${P}-ignore-autoconf-check.patch"
)

#pkg_setup() {
#	python-any-r1_pkg_setup
#}

#src_prepare() {
#	default

	# cd "${S}/gtk"
	# Don't run autogen.sh.
	# sed -i '/autogen.sh/d' module.rules || die "Removing autogen.sh call failed"
	# eautoreconf
#}

src_configure() {
	./configure \
		--force \
		--verbose \
		--prefix="${EPREFIX}/usr" \
		--disable-gtk-update-checks \
		--disable-flatpak \
		$(usex fdk --enable-fdk-aac) \
		$(usex !gtk --disable-gtk) \
		$(usex !gstreamer --disable-gst) \
		$(use_enable numa) \
		$(use_enable x265) || die "Configure failed."
}

src_compile() {
	emake -C build

	# TODO: Documentation building is currently broken, try to fix it.
	#
	# if use doc ; then
	# 	emake -C build doc
	# fi
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

	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
