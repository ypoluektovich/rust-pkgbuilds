m4_divert_push([STDOUT])dnl
# Maintainer: Yanus Poluektovich <ypoluektovich@gmail.com>
pkgname='rust-std-TRIPLE'
pkgver=PKGVER
pkgrel=PKGREL
pkgdesc="Rust standard library from official distribution package for triple TRIPLE"
arch=('any')
url="https://www.rust-lang.org/"
license=('Apache' 'MIT')
options=('staticlibs' '!strip')
_archive_name="rust-std-${pkgver}-TRIPLE"
source=("https://static.rust-lang.org/dist/${_archive_name}.tar.gz"{,.asc})
sha256sums=('CHECKSUM' 'SIGSUM')
validpgpkeys=('108F66205EAEB0AAA8DD5E1C85AB96E6FA1BE5FE')

package() {
    rm "${_archive_name}/$pkgname/manifest.in"
    cp -r "${srcdir}/${_archive_name}/${pkgname}" "${pkgdir}/usr"
}
m4_divert_pop([STDOUT])dnl
