# Maintainer: Antoine POPINEAU <antoine.popineau@appscho.com>

pkgname=btrfs-transient
pkgdesc='Use ephemeral BTRFS root filesystems'
pkgver=0.1
pkgrel=1
arch=('any')
depends=('mkinitcpio')
source=('git://github.com/apognu/btrfs-transient-rootfs')
sha1sums=('SKIP')

package() {
  cd "${srcdir}/btrfs-transient-rootfs"
  cp -a etc/ usr/ $pkgdir
}