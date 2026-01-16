EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE=""

RDEPEND="
	dev-vcs/git
	dev-embedded/u-boot-tools
	sys-apps/dtc
	dev-python/gitpython
	dev-python/rich
	sys-fs/squashfs-tools
	app-admin/sudo
	dev-python/pyelftools
	net-dialup/minicom
	cross-aarch64-unknown-linux-gnu/binutils
	cross-aarch64-unknown-linux-gnu/gcc
	cross-aarch64-unknown-linux-gnu/glibc
	cross-aarch64-unknown-linux-gnu/linux-headers
	sci-electronics/verilator
	dev-util/dialog
	sci-electronics/dsview
	app-emulation/qemu
	net-fs/autofs
"
