EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="mainsail"

RDEPEND="
	dev-python/pip
	media-libs/openjpeg
	x11-libs/wxGTK
	x11-base/xorg-server
	sys-apps/systemd[policykit(+)]
	x11-apps/xsetroot
	x11-apps/xset
	sys-apps/i2c-tools
"
