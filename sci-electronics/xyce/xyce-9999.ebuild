EAPI=8

inherit git-r3 cmake

DESCRIPTION="The Xyce Parallel Electronic Simulator is a SPICE-compatible circuit simulator"
HOMEPAGE="https://xyce.sandia.gov/about-xyce/"

CMAKE_MAKEFILE_GENERATOR=emake

EGIT_REPO_URI="https://github.com/Xyce/Xyce.git"
EGIT_COMMIT="2d93caa9358b276e774ab5906bac6a6b2d563c81"
EGIT_SUBMODULES=( '*' )

KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
SLOT="0"
IUSE="cuda openmp"

DEPEND="
	sci-libs/fftw
	sci-libs/suitesparse
	virtual/blas
	sci-libs/trilinos
	openmp? ( virtual/mpi[nullmpi(+)] )
	cuda? ( >=dev-util/nvidia-cuda-toolkit-3.2 )
	dev-perl/XML-LibXML
"
RDEPEND="
	${DEPEND}
"

PATCHES=(
	"${FILESDIR}"/install_fix.patch
	"${FILESDIR}"/cuda_fix.patch
)

#src_prepare() {
	#./bootstrap
	#autoheader
	#libtoolize --force --copy
	#aclocal -I config
	#automake --foreign --add-missing --copy
	#autoconf
	#autoheader
#	eapply_user
#	eautoreconf
#}

src_configure() {
	#econf \
	#	LDFLAGS="-L${PREFIX}/lib64/trilinos ${LDFLAGS}" \
	#	--enable-fftw \
	#	--enable-stokhos \
	#	--enable-amesos2 \
	#	--enable-mpi \
	#	--enable-superlu \
	#	--enable-shylu \
	#	--enable-curl \
	#	--disable-amd
#	./configure --prefix=/usr
	local mycmakeargs=(
#		-DCMAKE_INSTALL_PREFIX=/usr
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
			-DCMAKE_C_COMPILER=gcc
			-DCMAKE_CXX_COMPILER=nvcc_wrapper
			-DCMAKE_CXX_FLAGS:STRING="-allow-unsupported-compiler"
		)
		export CXX=nvcc_wrapper
	fi
	CPPFLAGS="-std=c++14" cmake_src_configure
}

#src_install() {
#	eninja install
#	rm -rf "${D}"/usr/doc
#}

pkg_preinst() {
    rm -rf "${D}"/usr/doc
}
