# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Previously Auto-Generated by cargo-ebuild 0.5.1-dev

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.12.1
	assert_cmd-2.0.8
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-1.1.0
	cc-1.0.78
	cfg-if-1.0.0
	clap-3.2.17
	clap_complete-3.2.4
	clap_lex-0.2.4
	clap_mangen-0.1.11
	config-file-0.2.3
	core-foundation-sys-0.8.3
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	difflib-0.4.0
	directories-4.0.1
	dirs-sys-0.3.7
	doc-comment-0.3.3
	either-1.8.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fastrand-1.8.0
	getrandom-0.2.7
	hashbrown-0.12.3
	hermit-abi-0.1.19
	indexmap-1.9.1
	instant-0.1.12
	io-lifetimes-1.0.4
	itertools-0.10.3
	lazy_static-1.4.0
	libc-0.2.139
	linux-raw-sys-0.1.4
	lscolors-0.13.0
	memchr-2.5.0
	memoffset-0.6.5
	ntapi-0.4.0
	nu-ansi-term-0.46.0
	num_cpus-1.13.1
	once_cell-1.17.0
	os_str_bytes-6.3.0
	overload-0.1.1
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro2-1.0.43
	quote-1.0.21
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	remove_dir_all-0.5.3
	roff-0.2.1
	rustix-0.36.7
	scopeguard-1.1.0
	serde-1.0.143
	serde_derive-1.0.143
	stfu8-0.2.5
	strsim-0.10.0
	syn-1.0.99
	sysinfo-0.27.7
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.2.3
	termtree-0.2.4
	textwrap-0.15.0
	thiserror-1.0.32
	thiserror-impl-1.0.32
	thousands-0.2.0
	toml-0.5.9
	unicode-ident-1.0.3
	unicode-width-0.1.9
	wait-timeout-0.2.0
	wasi-0.11.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
"

inherit cargo

DESCRIPTION="A more intuitive version of du"
HOMEPAGE="https://github.com/bootandy/dust"
SRC_URI="https://github.com/bootandy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris)"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
#
# Specifying `test` to ignore failing tests.
# See <https://github.com/bootandy/dust/issues/138>.
RESTRICT="mirror test"

QA_FLAGS_IGNORED="usr/bin/dust"

src_install() {
	cargo_src_install

	dodoc README.md
}
