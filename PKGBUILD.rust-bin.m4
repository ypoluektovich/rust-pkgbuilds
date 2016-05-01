m4_divert_push([STDOUT])dnl
# Maintainer: Yanus Poluektovich <ypoluektovich@gmail.com>
pkgname='rust-bin'
pkgver=PKGVER
pkgrel=PKGREL
pkgdesc="Rust standard library from official distribution package for triple TRIPLE"
arch=('i686' 'x86_64')
url="https://www.rust-lang.org/"
license=('Apache' 'MIT')
depends=("rust-std-$CARCH-unknown-linux-gnu=$pkgver")
provides=('rust')
conflicts=('rust')
options=('staticlibs' '!strip')
_archive_name="rustc-${pkgver}-$CARCH-unknown-linux-gnu"
source=("https://static.rust-lang.org/dist/${_archive_name}.tar.gz"{,.asc})
case "$CARCH" in
m4_foreach([ARCH_DEF], [ARCHITECTURES], [dnl
    "m4_argn(1, ARCH_DEF)" )
        sha256sums=('m4_argn(2, ARCH_DEF)' 'm4_argn(3, ARCH_DEF)')
        ;;
])dnl
esac
validpgpkeys=('108F66205EAEB0AAA8DD5E1C85AB96E6FA1BE5FE')

package() {
    find "${_archive_name}" -mindepth 1 -maxdepth 1 -type f -delete
    rm "${_archive_name}/rustc/manifest.in"
    cp -r "${srcdir}/${_archive_name}/rustc" "${pkgdir}/usr"
}
m4_divert_pop([STDOUT])dnl
