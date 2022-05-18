pkgname="numb"
pkgver="2.7.5"
pkgrel="1"
pkgdesk="numb_v2"
arch=("x86_64")
source=("numb.cpp")
sha512sums=("SKIP")
binPath="usr/local/bin"
package() {
	cmake .. 
	make
	rm CMakeCache.txt CMakeFiles/ cmake_install.cmake Makefile -rf
	mkdir -p "${pkgdir}/$binPath"

	cp "numb" "${pkgdir}/$binPath"
	cp "../message/" "${pkgdir}/$binPath/message" -r
	cp "../srcpy/" "${pkgdir}/$binPath/srcpy" -r
	chmod +x "${pkgdir}/$binPath/numb"



}
