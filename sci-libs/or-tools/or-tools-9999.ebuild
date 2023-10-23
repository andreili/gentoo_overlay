EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit cmake python-any-r1

DESCRIPTION="Google Optimization Tools"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/google/or-tools.git"
	EGIT_SUBMODULES=( '*' )
	EGIT_BRANCH="main"
	inherit git-r3

	PATCHES=(
		${FILESDIR}/latest_fix.patch
	)
else
	SRC_URI="https://github.com/google/${PN}/archive/refs/tags/v${PV}.zip"
fi

KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~arm64-macos"

SLOT="0"
IUSE="coinor cplex glpk python static-libs scip java parser samples examples doc express"

DEPEND="
	dev-libs/protobuf
	dev-cpp/abseil-cpp
	dev-libs/re2
	coinor? (
		sci-libs/coinor-utils
		sci-libs/coinor-osi
		sci-libs/coinor-clp
		sci-libs/coinor-cgl
		sci-libs/coinor-cbc
	)
	scip? ( sci-libs/scip )
	glpk? ( sci-mathematics/glpk )
	python? ( dev-python/pybind11 )
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
		-DBUILD_CXX=ON
		-DBUILD_DEPS=OFF
		-DBUILD_ZLIB=OFF
		-DBUILD_absl=OFF
		-DBUILD_GLOP=OFF
		-DBUILD_FLATZINC=OFF
		-DBUILD_Protobuf=OFF
		-DBUILD_re2=OFF
		-DBUILD_CoinUtils=OFF
		-DBUILD_Osi=OFF
		-DBUILD_Clp=OFF
		-DBUILD_Cgl=OFF
		-DBUILD_Cbc=OFF
		-DBUILD_GLPK=OFF
		-DBUILD_HIGHS=OFF
		-DBUILD_Eigen3=OFF
		-DBUILD_SCIP=OFF
		-DBUILD_DOTNET=OFF
		-DBUILD_pybind11=OFF
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
		-DBUILD_PYTHON=$(usex python)
		-DBUILD_JAVA=$(usex java)
		-DBUILD_LP_PARSER=$(usex parser)
		-DBUILD_SAMPLES=$(usex samples)
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_DOC=$(usex doc)
		-DUSE_COINOR=$(usex coinor)
		-DUSE_GLPK=$(usex glpk)
		-DUSE_HIGHS=OFF
		-DUSE_PDLP=OFF
		-DUSE_SCIP=$(usex scip)
		-DUSE_CPLEX=$(usex cplex)
		-DUSE_XPRESS=$(usex express)
	)
	if use python; then
		mycmakeargs+=( -DBUILD_VENV=OFF )
	fi
	cmake_src_configure
}
