EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit cmake python-any-r1 git-r3

DESCRIPTION="Google Optimization Tools"

#SRC_URI="https://github.com/The-OpenROAD-Project/OpenROAD/archive/refs/tags/v${PV}.tar.gz"
#S="${WORKDIR}/OpenROAD-${PV}"
EGIT_REPO_URI="https://github.com/google/or-tools.git"
EGIT_SUBMODULES=( '*' )

KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/protobuf
	dev-cpp/abseil-cpp
	dev-libs/re2
	sci-libs/coinor-cbc
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-util/cmake
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/"
		-DUSE_SCIP=OFF
	)
	cmake_src_configure
}
