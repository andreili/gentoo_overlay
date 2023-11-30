EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit cmake python-any-r1 git-r3

DESCRIPTION="Hardware design requires too much effort, cost and time"
HOMEPAGE="https://theopenroadproject.org/"

#SRC_URI="https://github.com/The-OpenROAD-Project/OpenROAD/archive/refs/tags/v${PV}.tar.gz"
#S="${WORKDIR}/OpenROAD-${PV}"
EGIT_REPO_URI="https://github.com/The-OpenROAD-Project/OpenROAD.git"
EGIT_SUBMODULES=( '*' )

PATCHES=(
    "${FILESDIR}"/${PN}_build1.patch
    ${FILESDIR}/cxx13_fix.patch
)


KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
SLOT="0"
IUSE="test"

DEPEND="
	dev-libs/spdlog
	dev-cpp/eigen
	sci-libs/lemon
	dev-cpp/gtest
	sci-libs/or-tools
	dev-lang/swig
	dev-libs/boost
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
		#-DUSE_SYSTEM_ABC=true
		-DUSE_SYSTEM_BOOST=true
		-DCMAKE_CXX_FLAGS="-DFMT_DEPRECATED_OSTREAM=1"
		-DCMAKE_BUILD_TYPE="RELEASE"
		-DBUILD_SHARED_LIBS=NO
	)
	if use test; then
		mycmakeargs+=(
			-DENABLE_TESTS=ON
		)
	else
		mycmakeargs+=(
			-DENABLE_TESTS=OFF
		)
	fi
	cmake_src_configure
}
