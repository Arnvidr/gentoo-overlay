# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rt-sources/rt-sources-3.8.13_p15.ebuild,v 1.1 2013/08/19 12:09:31 psomas Exp $

EAPI="8"
ETYPE="sources"
KEYWORDS="~amd64"

HOMEPAGE="https://wiki.linuxfoundation.org/realtime/start"

CKV="$(ver_cut 1-3)"
K_SECURITY_UNSUPPORTED="1"
# Find genpatches version at https://gitweb.gentoo.org/proj/linux-patches.git
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="83"
K_DEBLOB_AVAILABLE="1"
RT_PATCHSET="${PV/*_p}"

inherit kernel-2
K_NOSETEXTRAVERSION="yes"
detect_version
detect_arch

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"
RT_FILE="patch-${K_BRANCH_ID}.${KV_PATCH}-rt${RT_PATCHSET}.patch.xz"
RT_URI="https://www.kernel.org/pub/linux/kernel/projects/rt/${K_BRANCH_ID}/${RT_FILE} \
		https://www.kernel.org/pub/linux/kernel/projects/rt/${K_BRANCH_ID}/older/${RT_FILE}"

DESCRIPTION="Full Linux ${K_BRANCH_ID} kernel sources with the CONFIG_PREEMPT_RT patch"
SRC_URI="${KERNEL_URI} ${RT_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KV_FULL="${PVR/_p/-rt}"
S="${WORKDIR}/linux-${KV_FULL}"

UNIPATCH_LIST="${DISTDIR}/${RT_FILE}"
UNIPATCH_STRICTORDER="yes"

src_prepare() {
	default

	# 627796
	sed \
		"s/default PREEMPT_NONE/default PREEMPT_RT/g" \
		-i "${S}/kernel/Kconfig.preempt"
}

pkg_postinst(){
	kernel-2_pkg_postinst
	ewarn
	ewarn "${PN} are *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the RT project developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds."
	ewarn
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

K_EXTRAEINFO="For more info on rt-sources and details on how to report problems, see: \
${HOMEPAGE}."
