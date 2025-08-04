# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.2-gtk3"
SL_GTK="3"
MY_PN="OrcaSlicer"
MY_PV="$(ver_rs 3 -)"

inherit cmake xdg wxwidgets

DESCRIPTION="Orca Slicer is an open source slicer for FDM printers."
HOMEPAGE="https://github.com/SoftFever/OrcaSlicer"
if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
    #SRC_URI="https://github.com/SoftFever/OrcaSlicer/archive/refs/tags/nightly-builds.tar.gz -> ${P}.tar.gz"
	EGIT_REPO_URI="https://github.com/SoftFever/OrcaSlicer.git"
else
    SRC_URI="https://github.com/SoftFever/OrcaSlicer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
    S="${WORKDIR}/${MY_PN}-${MY_PV}"
fi


LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libmspack
	media-libs/gstreamer
	app-crypt/libsecret
	gui-libs/eglexternalplatform
	media-libs/glew
	dev-libs/boost:=[nls]
	media-libs/glfw
	media-gfx/openvdb
	dev-cpp/tbb
	dev-libs/cereal
	sci-libs/nlopt
	<sci-mathematics/cgal-6.0
	sci-libs/opencascade
	media-libs/mesa:=[osmesa]
	net-libs/webkit-gtk:4.1
	x11-libs/wxGTK:${WX_GTK_VER}[X,opengl,gstreamer,webkit,curl]
"
DEPEND="${RDEPEND}
"

PATCHES=(
#	"${FILESDIR}/wxgtk3-wayland-fix.patch"
	"${FILESDIR}/fix_upstream.patch"
#	"${FILESDIR}/exp.patch"
)

src_prepare() {
	sed -i "s/+UNKNOWN/_$(date '+%F')/" version.inc
	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	append-flags -fno-strict-aliasing
	setup-wxwidgets

	local mycmakeargs=(
		-DOPENVDB_FIND_MODULE_PATH="/usr/$(get_libdir)/cmake/OpenVDB"
		-DSLIC3R_GTK=${SL_GTK}
		-DBBL_RELEASE_TO_PUBLIC=1 -DBBL_INTERNAL_TESTING=0
		-DSLIC3R_STATIC=OFF
		-DSLIC3R_WX_STABLE=OFF
		-DSLIC3R_GUI=ON
		-DSLIC3R_PCH=OFF
		-DSLIC3R_FHS=OFF
		-DORCA_TOOLS=ON
		-Wno-dev
	)

	cmake_src_configure
}
