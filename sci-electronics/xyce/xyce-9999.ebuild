EAPI=8

inherit cmake

DESCRIPTION="The Xyce Parallel Electronic Simulator is a SPICE-compatible circuit simulator"
HOMEPAGE="https://xyce.sandia.gov/about-xyce/"

CMAKE_MAKEFILE_GENERATOR=emake

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/Xyce/Xyce.git"
	EGIT_SUBMODULES=( '*' )
	#EGIT_COMMIT="2d93caa9358b276e774ab5906bac6a6b2d563c81"
	inherit git-r3
else
	SRC_URI="https://github.com/Xyce/Xyce/archive/refs/tags/Release-${PV}.0.zip"
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~arm64-macos"
	S="${PORTAGE_BUILDDIR}/work/Xyce-Release-${PV}.0"
fi

SLOT="0"
IUSE="cuda openmp"

DEPEND="
	sci-libs/fftw
	sci-libs/suitesparse
	virtual/blas
	sci-libs/trilinos
	openmp? ( virtual/mpi[nullmpi(+)] )
	dev-perl/XML-LibXML
"
RDEPEND="
	${DEPEND}
"

PATCHES=(
	"${FILESDIR}"/build_fix.patch
	"${FILESDIR}"/install_fix-${PV}.patch
	"${FILESDIR}"/cuda_fix.patch
)

src_configure() {
	local mycmakeargs=(
		-DXyce_PARALLEL_MPI="$(usex openmp)"
		#-DXyce_VERBOSE_LINEAR=True
		#-DXyce_DEBUG_CIRCUIT=True
		#-DXyce_OP_START=True
		#-DXyce_TOPOLOGY=True
		#-DXyce_VERBOSE_CONDUCTANCE=True
		#-DXyce_VERBOSE_NONLINEAR=True
		#-DXyce_VERBOSE_NOX=True
		#-DXyce_VERBOSE_TIME=True
		-DTrilinos_DIR="${PREFIX}/lib64/cmake/Trilinos"
	)
	if use openmp; then
		[ ! -z "${CC}"] && export OMPI_CC="${CC}" MPICH_CC="${CC}" && tc-export OMPI_CC MPICH_CC
		[ ! -z "${CXX}"] && export OMPI_CXX="${CXX}" MPICH_CXX="${CXX}" && tc-export OMPI_CXX MPICH_CXX
		export CC=mpicc CXX=mpicxx && tc-export CC CXX
	fi
	if use cuda; then
		mycmakeargs+=(
			-DCMAKE_CXX_FLAGS:STRING="-allow-unsupported-compiler"
		)
		export CXX=nvcc_wrapper NVCC_WRAPPER_DEFAULT_COMPILER=${CXX}
	fi
	CPPFLAGS="-std=c++14" cmake_src_configure
}

pkg_preinst() {
    rm -rf "${D}"/usr/doc
}
