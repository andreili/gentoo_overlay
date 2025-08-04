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
	cross-aarch64-linux-gnu/binutils
	cross-aarch64-linux-gnu/gcc
	cross-aarch64-linux-gnu/glibc
	cross-aarch64-linux-gnu/linux-headers
	cross-riscv32-unknown-elf/binutils
	cross-riscv32-unknown-elf/gcc
	cross-riscv32-unknown-elf/newlib
	sci-electronics/verilator
	dev-util/dialog
	sci-electronics/dsview
"
