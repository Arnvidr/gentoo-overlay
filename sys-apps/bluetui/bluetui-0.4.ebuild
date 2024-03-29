# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.11
	allocator-api2@0.2.16
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	async-channel@2.2.0
	autocfg@1.1.0
	backtrace@0.3.69
	bitflags@1.3.2
	bitflags@2.4.2
	bluer@0.17.1
	bytes@1.5.0
	cassowary@0.3.0
	castaway@0.2.2
	cc@1.0.90
	cfg-if@1.0.0
	clap@4.5.3
	clap_builder@4.5.2
	clap_derive@4.5.3
	clap_lex@0.7.0
	colorchoice@1.0.0
	compact_str@0.7.1
	concurrent-queue@2.4.0
	crossbeam-utils@0.8.19
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	custom_debug@0.6.1
	custom_debug_derive@0.6.1
	darling@0.20.8
	darling_core@0.20.8
	darling_macro@0.20.8
	dbus@0.9.7
	dbus-crossroads@0.5.2
	dbus-tokio@0.7.6
	dirs@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.2.4
	either@1.10.0
	equivalent@1.0.1
	event-listener@5.2.0
	event-listener-strategy@0.5.0
	fnv@1.0.7
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	getrandom@0.2.12
	gimli@0.28.1
	hashbrown@0.14.3
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	ident_case@1.0.1
	indexmap@2.2.5
	indoc@2.0.4
	itertools@0.12.1
	itoa@1.0.10
	lazy_static@1.4.0
	libc@0.2.153
	libdbus-sys@0.2.5
	libredox@0.0.1
	lock_api@0.4.11
	log@0.4.21
	lru@0.12.3
	macaddr@1.0.1
	memchr@2.7.1
	miniz_oxide@0.7.2
	mio@0.8.11
	nix@0.27.1
	num-derive@0.4.2
	num-traits@0.2.18
	num_cpus@1.16.0
	object@0.32.2
	once_cell@1.19.0
	option-ext@0.2.0
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	pin-project@1.1.5
	pin-project-internal@1.1.5
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.30
	proc-macro2@1.0.79
	quote@1.0.35
	ratatui@0.26.1
	redox_syscall@0.4.1
	redox_users@0.4.4
	rustc-demangle@0.1.23
	rustversion@1.0.14
	ryu@1.0.17
	scopeguard@1.2.0
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.114
	serde_spanned@0.6.5
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	slab@0.4.9
	smallvec@1.13.1
	socket2@0.5.6
	stability@0.1.1
	static_assertions@1.1.0
	strsim@0.10.0
	strsim@0.11.0
	strum@0.26.2
	strum_macros@0.26.2
	syn@1.0.109
	syn@2.0.52
	synstructure@0.13.1
	thiserror@1.0.58
	thiserror-impl@1.0.58
	tokio@1.36.0
	tokio-macros@2.2.0
	tokio-stream@0.1.15
	toml@0.8.11
	toml_datetime@0.6.5
	toml_edit@0.22.7
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-width@0.1.11
	utf8parse@0.2.1
	uuid@1.7.0
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winnow@0.6.5
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
"

inherit cargo

DESCRIPTION="TUI to manage bluetooth devices"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/pythops/bluetui"
SRC_URI="https://github.com/pythops/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 GPL-3 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror test"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/bluetui"

src_install() {
        cargo_src_install

        dodoc Readme.md
}
