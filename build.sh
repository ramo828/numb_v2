#! /bin/bash
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0;38m'
NOCOLOR='\033[0m'
name="numb_compile"
DEB_NAME="numb"
DEB_VERSION=2.3
OS="GNU/Linux"
PYTHON_SRC="srcpy"

LINEA1="########################################################\n########################################################\n"
LINEA2="########################################################\n########################################################\n"
LINEA3="########################################################\n########################################################"
LINEB1="#########################${WHITE}****${RED}###########################\n########################${WHITE}***${RED}#############################\n"
LINEB2="#######################${WHITE}***${RED}##${WHITE}**${RED}##########################\n#######################${WHITE}***${RED}##${WHITE}**${RED}##########################\n"
LINEB3="########################${WHITE}***${RED}#############################\n#########################${WHITE}****${RED}###########################"
LINEC1="########################################################\n########################################################\n"
LINEC2="########################################################\n########################################################\n"
LINEC3="########################################################\n########################################################"
clear
echo ${BLUE}$LINEA1$LINEA2$LINEA3
echo ${RED}$LINEB1$LINEB2$LINEB3
echo ${GREEN}$LINEC1$LINEC2$LINEC3
echo "${NOCOLOR}"
sleep 7
echo "${BLUE}"
echo "########################################################"
echo "#                                                      #"
echo "#      Sən bizimsən, bizimsən durduqca bədəndə Can,    #"
echo "#        Yaşa, yaşa, çox yaşa, ey şanlı Azərbaycan!    #"
echo "#                                                      #"
echo "#                                                      #"
echo "########################################################"
echo "${NOCOLOR}"
sleep 8
echo "${GREEN}Created Mammadli Ramiz"
sleep 1;
echo "${GREEN}Lazim olan fayllar yuklenir"
sleep 1;
echo "${GREEN}Biraz gozleyin"
sleep 1;
echo "${RED}Yuklenen fayllar temizlenir..."
sleep 2
echo "${GREEN}"

rm numb_v2 -rf
git clone https://github.com/ramo828/numb_v2.git
cd numb_v2

if [ "$(uname -o)" == $OS ];
then
{
	echo "Linux"
	BINPATH="usr/local/bin"
}
else {
	echo "Android"
	BINPATH="data/data/com.termux/files/usr/bin"
	yes | pkg upgrade
}
fi

echo $BINPATH
echo "Sistem Temizlenir..."
rm $name -rf
echo "Qovluq yaradilir..."
sleep 1
mkdir -p $name/$BINPATH
echo "Esas fayllar kopyalanir"
cp $PYTHON_SRC message $name -r
echo "Cython compile edilir"
cd $name/$PYTHON_SRC/
python "setup.py" build_ext --inplace
echo "C++ compile edilir"
cd ../../
echo "${NOCOLOR}"
cmake CMakeLists.txt
make -j$(nproc)
mv numb $name/$BINPATH
cd $name
mv $PYTHON_SRC message $BINPATH
echo "Lazimsiz fayllar temizlenir"
cd ../
echo "Lazımlı paketler yüklənir"
pip install --upgrade pip setuptools
pip install --upgrade pip
sleep 1;
echo 'Xəta baş verərsə kodu yenidən çalışdırın'
yes | pkg install curl clang zip python git make libxslt
sleep 3
rm cmake_install.cmake build CMakeFiles CMakeCache.txt -rf
sleep 1
echo "Python paketleri yuklenir..."
pip install -r requirements.txt
sleep 1
echo "Deb fayli hazirlanir"
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
	rm -rf CMakeFiles CMakeCache.txt srcpy/*.o  srcpy/pyx/*.c Makefile cmake_install.cmake
	sleep 2

if [ "$(uname -o)" == $OS ];
then
{
	echo "Linux"
	sudo dpkg -i *.deb
}
else {
	echo "Android"
	dpkg -i *.deb
	termux-setup-storage
}
fi

	cd ../
	rm numb_v2 -rf
	clear


