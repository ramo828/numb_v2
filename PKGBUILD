pkgname="numb"
pkgver="2.7.5"
pkgrel="1"
pkgdesk="numb_v2"
arch=("x86_64")
source=("numb.cpp")
sha512sums=("SKIP")

package() {
	cmake .. 
	make
	rm CMakeCache.txt CMakeFiles/ cmake_install.cmake Makefile -rf
	mkdir -p "${pkgdir}/usr/bin"

	cp "numb" "${pkgdir}/usr/bin/numb"
	cp "../message/" "${pkgdir}/usr/bin/message" -r
	cp "../srcpy/" "${pkgdir}/usr/bin/srcpy" -r
	chmod +x "${pkgdir}/usr/bin/numb"



}
