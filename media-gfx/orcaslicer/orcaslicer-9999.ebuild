# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DRACO_VER="1.5.7"
DRACO_FN="draco_${DRACO_VER}.zip"
CGAL_VER="5.6.3"
CGAL_FN="CGAL-${CGAL_VER}.zip"
EIGEN_VER="5.0.1"
EIGEN_FN="eigen-${EIGEN_VER}.zip"
NOISE_VER="1.0"
NOISE_FN="libnoise-${NOISE_VER}.zip"

DESCRIPTION="G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)"
HOMEPAGE="https://www.orcaslicer.com/"
if [[ ${PV} == 9999 ]]; then
    WX_GTK_VER="3.3-gtk3"
    inherit git-r3
    EGIT_REPO_URI="https://github.com/OrcaSlicer/OrcaSlicer.git"
    SRC_URI="https://github.com/google/draco/archive/refs/tags/${DRACO_VER}.zip -> ${DRACO_FN}
	     https://github.com/CGAL/cgal/releases/download/v${CGAL_VER}/${CGAL_FN}
	     https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VER}/${EIGEN_FN}
	     https://github.com/SoftFever/Orca-deps-libnoise/archive/refs/tags/${NOISE_VER}.zip -> ${NOISE_FN}"
    KEYWORDS=""
    S="${WORKDIR}/orcaslicer-${PV}"
else
    WX_GTK_VER="3.2-gtk3"
    SRC_URI="https://github.com/SoftFever/OrcaSlicer/archive/refs/tags/v${PV}.tar.gz"
    S="${WORKDIR}/OrcaSlicer-${PV}"
fi

CMAKE_BUILD_TYPE="Release"

inherit cmake desktop wxwidgets xdg

# Long story short, It's APGL3, with code forked from other AGPL3 slicers.
# It includes some code for a "pressure advance calibration pattern test" which is GPL3
LICENSE="AGPL3 GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    net-misc/curl[ssl]
    sys-apps/dbus
    gui-libs/eglexternalplatform
    media-libs/glew
    media-libs/glfw
    media-libs/glu
    net-libs/webkit-gtk
    dev-libs/boost
    media-gfx/openvdb[utils]
    media-libs/opencv[png]
    media-libs/qhull[static-libs]
    x11-libs/wxGTK:${WX_GTK_VER}=[webkit,curl,keyring]
    sci-mathematics/cgal
    sci-libs/opencascade
    dev-libs/cereal
    media-gfx/opencsg
    sci-libs/nlopt
    sci-mathematics/clipper2
    dev-cpp/fast_float
    dev-libs/hidapi
    sci-libs/libigl
    dev-libs/md4c
    media-libs/nanosvg
    dev-cpp/nlohmann_json
    media-libs/openexr
"
RDEPEND="
    ${DEPEND}
"
BDEPEND="
    virtual/pkgconfig
    dev-build/ninja
"

PATCHES=(
    "${FILESDIR}/0001-all-${PV}.patch"
)

src_prepare() {
    cmake_src_prepare
}

src_configure() {
    setup-wxwidgets
}

src_compile() {
    mkdir -p "${S}/deps/DL_CACHE/Draco"
    cp "${DISTDIR}/${DRACO_FN}" "${S}/deps/DL_CACHE/Draco/${DRACO_VER}.zip"
    mkdir -p "${S}/deps/DL_CACHE/CGAL"
    cp "${DISTDIR}/${CGAL_FN}" "${S}/deps/DL_CACHE/CGAL/${CGAL_FN}"
    mkdir -p "${S}/deps/DL_CACHE/Eigen"
    cp "${DISTDIR}/${EIGEN_FN}" "${S}/deps/DL_CACHE/Eigen/${EIGEN_FN}"
    mkdir -p "${S}/deps/DL_CACHE/libnoise"
    cp "${DISTDIR}/${NOISE_FN}" "${S}/deps/DL_CACHE/libnoise/${NOISE_VER}.zip"
    cmake_run_in ${S} cmake -S ${S}/deps -B deps/${P}_build -Wno-dev -DSYS_LIBS=all || die
    cmake_run_in ${S} cmake --build deps/${P}_build -j1 || die

    local mycmakeargs=(
	-DSLIC3R_GTK=3
	-DSLIC3R_STATIC=OFF
	-DSLIC3R_FHS=1
	-DSLIC3R_PCH=0
	-DBBL_RELEASE_TO_PUBLIC=1
	-DBBL_INTERNAL_TESTING=0
	
	-DORCA_TOOLS=ON
	-DUSE_BLOSC=TRUE
	-DSYS_LIBS=all
    )
    cmake_src_configure
    cmake_build
}

src_install() {
    cmake_src_install
    default
    rm "${D}/usr/LICENSE.txt" || die
    rm -r "${D}/usr/include" || die
    rm -r "${D}/usr/lib" || die
}
