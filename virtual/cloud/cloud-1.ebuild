# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+curl +imagemagick mysql postgres +sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND="dev-lang/php[curl?,filter,gd,hash(+),intl,json(+),mysql?,pdo,posix,postgres?,session,simplexml,sqlite?,truetype,xmlreader,xmlwriter,zip]
        imagemagick? ( dev-php/pecl-imagick )
        virtual/httpd-php
	media-libs/vips
	media-libs/exiftool
	dev-php/pdlib
	app-admin/sudo"
