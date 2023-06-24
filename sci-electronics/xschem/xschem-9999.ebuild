EAPI=8

inherit git-r3

DESCRIPTION="A schematic editor for VLSI/Asic/Analog custom designs"
HOMEPAGE="http://repo.hu/projects/xschem/index.html"

EGIT_REPO_URI="https://github.com/StefanSchippers/xschem.git"
EGIT_SUBMODULES=( '*' )

KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
SLOT="0"
IUSE=""

DEPEND="
	dev-lang/tcl
	x11-libs/cairo
	x11-libs/libxcb
	x11-libs/libXpm
	x11-terms/xterm
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	./configure --prefix=/usr
}
