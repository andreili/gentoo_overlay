EAPI=8

DESCRIPTION=""
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="
	app-admin/sudo
	net-dns/unbound
	net-misc/ntp
	net-misc/networkmanager
	net-vpn/openvpn
	app-misc/mosquitto[websockets(+)]
	net-analyzer/zabbix[agent,-server,-frontend,-mysql]
	sys-apps/pciutils
	virtual/mysql
	media-video/ffmpeg[jpeg2k,nvenc,openh264,theora,vorbis,x264,x265]
	media-libs/libjpeg-turbo
	sys-apps/nvme-cli
"
