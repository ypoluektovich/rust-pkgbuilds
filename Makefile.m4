m4_define([triple_pkg], [rust-std-TRIPLE-PKGVER-PKGREL-m4_echo(any)PKGEXT])dnl
m4_define([arch_pkg], [rust-bin-PKGVER-PKGREL-m4_echo(ARCH)PKGEXT])dnl
m4_divert_push(STDOUT)dnl
vpath %PKGEXT PKGDEST
GPATH = "PKGDEST"

build-for-self: rust-bin-PKGVER-PKGREL-m4_echo(CURRENT_ARCHITECTURE)PKGEXT all-std

all: all-std dnl
m4_foreach([ARCH_DEF], [ARCHITECTURES], [dnl
m4_define([ARCH], m4_argn(1, ARCH_DEF))dnl
 m4_echo(arch_pkg)dnl
])

all-std:dnl
m4_foreach([TRIPLE_DEF], [TRIPLES], [dnl
m4_define([TRIPLE], m4_argn(1, TRIPLE_DEF))dnl
 m4_echo(triple_pkg)dnl
])dnl

generate: PKGBUILD.rust-bin m4_foreach([TRIPLE_DEF], [TRIPLES], [ PKGBUILD.m4_argn(1, TRIPLE_DEF)])

m4_foreach([TRIPLE_DEF], [TRIPLES], [
m4_define([TRIPLE], [m4_argn(1, TRIPLE_DEF)])dnl
PKGBUILD.TRIPLE: Makefile
	m4 -R env.m4f -D [TRIPLE]=TRIPLE -D CHECKSUM=m4_argn(2, TRIPLE_DEF) -D SIGSUM=m4_argn(3, TRIPLE_DEF) PKGBUILD.rust-std.m4 >PKGBUILD.TRIPLE

triple_pkg: PKGBUILD.TRIPLE
	makepkg -C -p PKGBUILD.TRIPLE -c

])dnl

PKGBUILD.rust-bin: Makefile
	m4 -R env.m4f PKGBUILD.rust-bin.m4 >PKGBUILD.rust-bin

m4_foreach([ARCH_DEF], [ARCHITECTURES], [
m4_define([ARCH], [m4_argn(1, ARCH_DEF)])dnl
arch_pkg: PKGBUILD.rust-bin
	makepkg -C -p PKGBUILD.rust-bin -d -c

])dnl

clean:
	find -mindepth 1 -maxdepth 1 -name 'PKGBUILD.*' -a \! -name '*.m4' -delete
	find "PKGDEST" -mindepth 1 -maxdepth 1 -name '*PKGEXT' -delete
	rm -rf src pkg

distclean: clean
	rm env.m4 *.m4f Makefile

.PHONY: clean distclean
m4_divert_pop(STDOUT)dnl
