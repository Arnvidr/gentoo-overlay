# Copyright 2019-2022 Gianni Bombelli <bombo82@giannibombelli.it>
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit check-reqs desktop wrapper

MY_PV=idea-$(ver_cut 1-3)

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="https://www.jetbrains.com/idea"

SRC_URI="https://download.jetbrains.com/idea/${MY_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/idea-IC-${PV}"
LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 CC-BY-2.5 CDDL-1.1
      codehaus-classworlds CPL-1.0 EPL-1.0 EPL-2.
      GPL-2 GPL-2-with-classpath-exception ISC
      JDOM LGPL-2.1 LGPL-2.1+ LGPL-3-with-linking-exception MIT
      MPL-1.0 MPL-1.1 OFL-1.1 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-17:*"

RDEPEND="${DEPEND}
	dev-java/jansi-native
	dev-libs/libdbusmenu
	dev-libs/libpcre2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	llvm-core/lldb
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/mesa[X(+)]
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/pam
	sys-process/audit
	virtual/zlib:=
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango"

QA_PREBUILT="opt/${PN}/*"

BDEPEND="dev-util/patchelf"
RESTRICT="splitdebug"

pkg_pretend() {
      CHECKREQS_DISK_BUILD="4G"
      check-reqs_pkg_pretend
}

pkg_setup() {
      CHECKREQS_DISK_BUILD="4G"
      check-reqs_pkg_pretend
}

src_unpack() {
      default_src_unpack
      if [ ! -d "$S" ]; then
              einfo "Renaming source directory to predictable name..."
              mv $(ls "${WORKDIR}") "idea-IC-${PV}" || die
      fi
}

src_prepare() {
	default_src_prepare

	JRE_DIR=jre64
	rm -vf "${S}"/plugins/cwm-plugin/quiche-native/linux-aarch64/libquiche.so

	PLUGIN_DIR="${S}/${JRE_DIR}/lib/"

	# rm LLDBFrontEnd after licensing questions with Gentoo License Team
	rm -vf "${S}"/plugins/Kotlin/bin/linux/LLDBFrontend
	rm -vf ${PLUGIN_DIR}/libavplugin*
	rm -vf "${S}"/plugins/maven/lib/maven3/lib/jansi-native/*/libjansi*
	rm -vrf "${S}"/lib/pty4j-native/linux/ppc64le
	rm -vf "${S}"/bin/libdbm64*
	rm -vf "${S}"/lib/pty4j-native/linux/mips64el/libpty.so

	if [[ -d "${S}"/"${JRE_DIR}" ]]; then
	        for file in "${PLUGIN_DIR}"/{libfxplugins.so,libjfxmedia.so}
	        do
	                if [[ -f "$file" ]]; then
	                  patchelf --set-rpath '$ORIGIN' $file || die
	                fi
	        done
	fi

	if [[ -d "${S}"/lib/async-profiler/ ]]; then
	        rm -rv "${S}"/lib/async-profiler/aarch64/libasyncProfiler.so || die
	fi

	rm -vf "${S}"/lib/pty4j-native/linux/x86-64/libpty.so

	sed -i \
	        -e "\$a\\\\" \
	        -e "\$a#-----------------------------------------------------------------------" \
	        -e "\$a# Disable automatic updates as these are handled through Gentoo's" \
	        -e "\$a# package manager. See bug #704494" \
	        -e "\$a#-----------------------------------------------------------------------" \
	        -e "\$aide.no.platform.update=Gentoo"  bin/idea.properties

	patchelf --set-rpath '$ORIGIN' "jbr/lib/libjcef.so" || die
	patchelf --set-rpath '$ORIGIN' "jbr/lib/libcef.so" || die
	patchelf --set-rpath '$ORIGIN' "jbr/lib/jcef_helper" || die
	patchelf --set-rpath '$ORIGIN/../lib' "${S}"/plugins/remote-dev-server/selfcontained/bin/{Xvfb,xkbcomp} || die
	patchelf --set-rpath '$ORIGIN' "${S}"/plugins/remote-dev-server/selfcontained/lib/lib*.so* || die

	rm plugins/platform-ijent-impl/ijent-aarch64-unknown-linux-musl-release

	eapply_user
}

src_install() {
	local dir="/opt/${PN}"
	local dst="${D}${dir}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{format.sh,idea,idea.sh,inspect.sh,restarter,fsnotifier}

	if [[ -d jbr ]]; then
	        fperms 755 "${dir}"/jbr/bin/{java,javac,javadoc,jcmd,jdb,jfr,jhsdb,jinfo,jmap,jps,jrunscript,jstack,jstat,jwebserver,keytool,rmiregistry,serialver}
	        # Fix #763582
	        fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}
	fi

	JRE_DIR=jre

	JRE_BINARIES="jaotc java javapackager jjs jrunscript keytool pack200 rmid rmiregistry unpack200"
	if [[ -d ${JRE_DIR} ]]; then
	        for jrebin in $JRE_BINARIES; do
	                fperms 755 "${dir}"/"${JRE_DIR}"/bin/"${jrebin}"
	        done
	fi

	# bundled script is always lowercase, and doesn't have -ultimate, -professional suffix.
	local bundled_script_name="${PN#*-}.sh"

	make_wrapper "${PN}" "${dir}/bin/$bundled_script_name" || die

	local pngfile="$(find ${dst}/bin -maxdepth 1 -iname '*.png')"
	newicon $pngfile "${PN}.png" || die "we died"
	make_desktop_entry "/opt/intellij-idea/bin/idea" "IntelliJ IDEA" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/" || die
	echo "fs.inotify.max_user_watches = 524288" > "${D}/usr/lib/sysctl.d/30-${PN}-inotify-watches.conf" || die

	# remove bundled harfbuzz
	rm -f "${D}"/lib/libharfbuzz.so || die "Unable to remove bundled harfbuzz"
}

