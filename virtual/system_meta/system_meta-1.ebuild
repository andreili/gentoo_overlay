# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="kernel"
REQUIRED_USE=""

RDEPEND="app-editors/nano
	app-eselect/eselect-repository
	app-misc/mc
	app-portage/eix
	app-portage/gentoolkit
	net-fs/nfs-utils
	net-misc/chrony
	net-misc/networkmanager
	kernel? ( sys-kernel/genkernel )
	sys-process/htop
	sys-process/iotop
	kernel? ( virtual/linux-sources )
"
