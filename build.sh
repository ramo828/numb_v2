name="numb_compile"
DEB_NAME="numb"
DEB_VERSION=2.0
OS="GNU/Linux"

if [ "$(uname -o)" == $OS ];
then
{
	echo "Linux"
	BINPATH="usr/local/bin"
}
else
	echo "Android"
	BINPATH="data/data/com.termux/files/usr/bin"
fi

echo $BINPATH
echo "Sistem Temizlenir..."
rm $name -rf
echo "Qovluq yaradilir..."
sleep 1
mkdir -p $name/$BINPATH
echo "Esas fayllar kopyalanir"
cp python message $name -r
echo "Cython compile edilir"
cd $name/python/
python "setup.py" build_ext --inplace
echo "C++ compile edilir"
cd ../../
cmake CMakeLists.txt
make
mv numb $name/$BINPATH
cd $name
mv python message $BINPATH
echo "Lazimsiz fayllar temizlenir"
cd ../
rm cmake_install.cmake build CMakeFiles CMakeCache.txt -rf
sleep 1
echo "Python paketleri yuklenir..."
pip install -r requirements.txt
sleep 1
echo "Deb fayli hazirlanir"
mv numb $name
	mkdir -p $name/DEBIAN/
	touch $name/DEBIAN/control
	chmod -R 0755 $name
	echo "Package: $DEB_NAME" >> $name/DEBIAN/control
	echo "Version: $DEB_VERSION" >> $name/DEBIAN/control
	echo "Architecture: all" >> $name/DEBIAN/control
	echo "Maintainer: RamoSoft <illegalism666@gmail.com>" >> $name/DEBIAN/control
	echo "Description: Bakcell && Azercell Tools" >> $name/DEBIAN/control
	echo " Programin esas meqsedi nomre satisi zamani mumkun qeder vaxta qenaet etmekdir" >> $name/DEBIAN/control
	#umask 22
	dpkg-deb --build --root-owner-group $name
	rm -rf CMakeFiles CMakeCache.txt .config python/*.o  python/pyx/*.c Makefile cmake_install.cmake
	sleep 2
	clear


