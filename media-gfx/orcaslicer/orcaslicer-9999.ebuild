# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
CMAKE_BUILD_TYPE="Release"

inherit cmake desktop wxwidgets xdg

# Long story short, It's APGL3, with code forked from other AGPL3 slicers.
# It includes some code for a "pressure advance calibration pattern test" which is GPL3
LICENSE="AGPL3 GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DESCRIPTION="G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)"
HOMEPAGE="https://www.orcaslicer.com/"
if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/OrcaSlicer/OrcaSlicer.git"
    KEYWORDS=""
    S="${WORKDIR}/orcaslicer-${PV}"
else
    SRC_URI="https://github.com/SoftFever/OrcaSlicer/archive/refs/tags/v${PV}.tar.gz"
    S="${WORKDIR}/OrcaSlicer-${PV}"
fi

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
"
RDEPEND="
    ${DEPEND}
"
BDEPEND="
    virtual/pkgconfig
    dev-build/ninja
"

PATCHES=(
    "${FILESDIR}/0001-Use-system-GMP-MPFR.patch"
    "${FILESDIR}/0002-Move-to-external-OCCT-library_${PV}.patch"
    "${FILESDIR}/0003-Move-Blosc-CURL-OpenSSL-Qhull-to-system-library.patch"
    "${FILESDIR}/0004-Move-GLEW-cereal-NLopt-to-system-library.patch"
    "${FILESDIR}/0005-Move-to-CGAL-6.1-system-lib.patch"
    "${FILESDIR}/0006-Move-GLWF-TBB-OpenVDB-OpenCSG-to-system-sibrary.patch"
    "${FILESDIR}/0007-Move-OpenCV-to-a-system-lib.patch"
    "${FILESDIR}/0008-Move-Wx-to-system-lib_${PV}.patch"
    "${FILESDIR}/0009-Fix-new-boost-library-usage.patch"
    "${FILESDIR}/0010-Small-fixes-for-warnings.patch"
    "${FILESDIR}/0011-Disable-Draco-files-support.patch"
    "${FILESDIR}/0012-gentoo-libs.patch"
)

src_configure() {
    setup-wxwidgets
    local mycmakeargs=(
	-DSLIC3R_GTK=3
	-DSLIC3R_STATIC=OFF
	-DSLIC3R_FHS=1
	-DSLIC3R_PCH=0
	
	-DBBL_RELEASE_TO_PUBLIC=1
	-DBBL_INTERNAL_TESTING=0
	
	-DORCA_TOOLS=ON
	-DUSE_BLOSC=TRUE
    )
    cmake_src_configure
}

src_install() {
    cmake_src_install
    default
    rm "${D}/usr/LICENSE.txt" || die
    rm -r "${D}/usr/include" || die
    rm -r "${D}/usr/lib" || die
}
