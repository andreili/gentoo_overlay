EAPI=8

DESCRIPTION="A schematic editor for VLSI/Asic/Analog custom designs"
HOMEPAGE="http://repo.hu/projects/xschem/index.html"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/StefanSchippers/xschem.git"
	EGIT_SUBMODULES=( '*' )
	inherit git-r3
else
	SRC_URI="https://github.com/StefanSchippers/${PN}/archive/refs/tags/${PV}.zip"
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~arm64-macos"
fi

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
