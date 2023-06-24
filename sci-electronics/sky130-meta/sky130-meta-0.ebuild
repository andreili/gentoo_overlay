EAPI=7

inherit multilib-build

DESCRIPTION="Meta-package for Google SKY130 programm"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sci-electronics/magic
	sci-electronics/openroad
	sci-electronics/xschem
	sci-electronics/ngspice
	sci-electronics/xyce
	app-containers/docker
	app-containers/docker-cli
	dev-python/pip
	sci-electronics/gtkwave[lzma(+)]"

RDEPEND="${DEPEND}"
