EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE=""

RDEPEND="
	dev-vcs/git
	dev-embedded/u-boot-tools
	sys-apps/dtc
	cross-aarch64-unknown-linux-gnu/binutils
	cross-aarch64-unknown-linux-gnu/gcc
	cross-aarch64-unknown-linux-gnu/glibc
	sys-fs/squashfs-tools
	dev-debug/gdb
"
