# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	allocator-api2@0.2.21
	anstream@0.6.18
	anstyle@1.0.10
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	async-channel@2.3.1
	autocfg@1.4.0
	backtrace@0.3.74
	bitflags@2.6.0
	bluer@0.17.3
	bytes@1.9.0
	cassowary@0.3.0
	castaway@0.2.3
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clap@4.5.23
	clap_builder@4.5.23
	clap_derive@4.5.18
	clap_lex@0.7.4
	colorchoice@1.0.3
	compact_str@0.8.0
	concurrent-queue@2.5.0
	coolor@1.0.0
	crossbeam-utils@0.8.21
	crossterm@0.28.1
	crossterm_winapi@0.9.1
	custom_debug@0.6.2
	custom_debug_derive@0.6.2
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dbus@0.9.7
	dbus-crossroads@0.5.2
	dbus-tokio@0.7.6
	diff@0.1.13
	dirs@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.2.5
	either@1.13.0
	equivalent@1.0.1
	errno@0.3.10
	event-listener@5.3.1
	event-listener-strategy@0.5.3
	fnv@1.0.7
	foldhash@0.1.4
	futures@0.3.31
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	getrandom@0.2.15
	gimli@0.31.1
	hashbrown@0.15.2
	heck@0.5.0
	hex@0.4.3
	ident_case@1.0.1
	indexmap@2.7.0
	indoc@2.0.5
	instability@0.3.5
	is_terminal_polyfill@1.70.1
	itertools@0.13.0
	itoa@1.0.14
	lazy_static@1.5.0
	libc@0.2.169
	libdbus-sys@0.2.5
	libredox@0.1.3
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	lru@0.12.5
	macaddr@1.0.1
	memchr@2.7.4
	miniz_oxide@0.8.2
	mio@1.0.3
	nix@0.29.0
	num-derive@0.4.2
	num-traits@0.2.19
	object@0.36.7
	option-ext@0.2.0
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pin-project@1.1.7
	pin-project-internal@1.1.7
	pin-project-lite@0.2.15
	pin-utils@0.1.0
	pkg-config@0.3.31
	pretty_assertions@1.4.1
	proc-macro2@1.0.92
	quote@1.0.37
	ratatui@0.29.0
	redox_syscall@0.5.8
	redox_users@0.4.6
	rustc-demangle@0.1.24
	rustix@0.38.42
	rustversion@1.0.18
	ryu@1.0.18
	scopeguard@1.2.0
	serde@1.0.216
	serde_derive@1.0.216
	serde_json@1.0.134
	serde_spanned@0.6.8
	signal-hook@0.3.17
	signal-hook-mio@0.2.4
	signal-hook-registry@1.4.2
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.8
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@2.0.90
	synstructure@0.13.1
	terminal-light@1.7.0
	thiserror@1.0.69
	thiserror-impl@1.0.69
	tokio@1.42.0
	tokio-macros@2.4.0
	tokio-stream@0.1.17
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tui-input@0.11.1
	unicode-ident@1.0.14
	unicode-segmentation@1.12.0
	unicode-truncate@1.1.0
	unicode-width@0.1.14
	unicode-width@0.2.0
	utf8parse@0.2.2
	uuid@1.11.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	xterm-query@0.5.0
	yansi@1.0.1
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