# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

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
IUSE="dolby +fdk gstreamer gtk3 gtk4 numa nvenc x265"

REQUIRED_USE="
	numa? ( x265 )
	gtk3? ( !gtk4 )
	gtk4? ( !gtk3 )
"

RDEPEND="
	app-arch/xz-utils
	dev-libs/fribidi
	dev-libs/jansson:=
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libass:=
	media-libs/libjpeg-turbo:=
	media-libs/libogg
	media-libs/libsamplerate
	media-libs/libtheora
	media-libs/libvorbis
	>=media-libs/libvpx-1.12.0:=
	media-libs/opus
	media-libs/speex
	media-libs/x264:=
	media-sound/lame
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
	gtk4? (
		>=gui-libs/gtk-4.4
	)
	gtk3? (
		>=x11-libs/gtk+-3.10
		dev-libs/dbus-glib
		>=dev-libs/glib-2.56
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/libnotify
		x11-libs/pango
	)
	x265? ( >=media-libs/x265-3.2:0=[10bit,12bit,numa?] )
	"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-build/ninja
	dev-lang/yasm
	dev-util/intltool
"

src_prepare() {
	default
}

src_configure() {
	tc-export AR RANLIB STRIP

	./configure \
		--force \
		--verbose \
		--prefix="${EPREFIX}/usr" \
		--disable-flatpak \
		--enable-ffmpeg-aac \
		$(usex fdk --enable-fdk-aac) \
		$(use_enable gtk3 gtk) \
		$(use_enable gtk4) \
		$(usex !gstreamer --disable-gst) \
		$(use_enable numa) \
		$(use_enable dolby libovi) \
		$(use_enable nvenc) \
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

	if use gtk4 ; then
		einfo ""
		einfo "For the GTK+ version of HandBrake, you can run \`ghb\`."
	fi

	xdg_pkg_postinst
}
