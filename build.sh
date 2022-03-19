#! /bin/bash

YELLOW='\033[0;33m'
NOCOLOR='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
WHITE='\033[0;38m'
name="numb_compile"
DEB_NAME="numb"
DEB_VERSION=2.3
PYTHON_SRC="srcpy"
RED='\033[0;31m'
OS="GNU/Linux"
if [ "$(uname -o)" = "$OS" ];
then
{
	echo "${RED}Linux${NOCOLOR}"
	WHITE='\033[0;32m'
	GREEN='\033[0;38m'
	BINPATH="usr/local/bin"
	echo "${WHITE}"
	sudo apt-get install curl clang zip python3 git make libxslt*-dev
	echo "${NOCOLOR}"

}
else {
	echo "${RED}Android${NOCOLOR}"
	BINPATH="data/data/com.termux/files/usr/bin"
	echo "${GREEN}"
	yes | pkg upgrade
	yes | pkg install curl clang zip python git make libxslt
	echo "${NOCOLOR}"
}
fi

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
echo "${YELLOW}Yuklenen fayllar temizlenir...${NOCOLOR}"
sleep 2
echo "${GREEN}"

while getopts c: flag
do
    case "${flag}" in
        c) comp_status=${OPTARG};;
    esac
done

if [ "${comp_status}" = "true" ];
then
{
	echo "${YELLOW}Local compile${NOCOLOR}"
}
else {
	echo "${YELLOW}Rwmote compile${NOCOLOR}"
	rm numb_v2 -rf
	git clone https://github.com/ramo828/numb_v2.git
	cd numb_v2
}
fi
echo $BINPATH
echo "${YELLOW}Sistem Temizlenir..."
rm $name -rf
echo "Qovluq yaradilir..."
sleep 1
mkdir -p $name/$BINPATH
echo "Esas fayllar kopyalanir"
cp $PYTHON_SRC message $name -r
echo "Cython compile edilir${NOCOLOR}"
cd $name/$PYTHON_SRC/
echo "${GREEN}"
python "setup.py" build_ext --inplace
echo "${NOCOLOR}"
echo "${YELLOW}C++ compile edilir${NOCOLOR}"
cd ../../

echo '			 ___  _            _'   
echo '			| _ )| | __ _  __ | |__'
echo '			| _ \| |/ _` |/ _|| / /'
echo '			|___/|_|\__,_|\__||_\_\'

echo '		 	    ___    _  _____ '
echo '			   / __|  /_\|_   _|'
echo '		 	  | (__  / _ \ | |  '
echo '			   \___|/_/ \_\|_|  '
	
echo '		 ___         _             _'
echo '		| __| _ __  (_) _ _  __ _| |_  ___  ___'
echo '		| _| | ^  \ | || _|/ _` ||  _|/ -_)(_-<'
echo '		|___||_|_|_||_||_| \__,_| \__|\___|/__/'


echo '\033[5m	
		                        _
		                       | \
		                       | |
		                       | |
		  |\                   | |
		 /, ~\                / /
		X     `-.....-------./ /
		 ~-. ~  ~              |
		    \             /    |
		     \  /_     ___\   /
		     | /\ ~~~~~   \ |
		     | | \        || |
		     | |\ \       || )
		    (_/ (_/      ((_/
\033[0m'	
 
cmake CMakeLists.txt
make -j$(nproc)
mv numb $name/$BINPATH
cd $name
mv $PYTHON_SRC message $BINPATH
echo "${YELLOW}Lazimsiz fayllar temizlenir"
cd ../
echo "Lazımlı paketler yüklənir${NOCOLOR}"
pip install --upgrade pip setuptools
pip install --upgrade pip
sleep 1;
echo "${YELLOW}Xəta baş verərsə kodu yenidən çalışdırın"
sleep 3
rm cmake_install.cmake build CMakeFiles CMakeCache.txt -rf
sleep 1
echo "Python paketleri yuklenir...${NOCOLOR}"
pip install -r requirements.txt
sleep 1
echo "${YELLOW}Deb fayli hazirlanir${NOCOLOR}"
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

if [ "$(uname -o)" = "$OS" ];
then
{
	echo "${RED}Linux${NOCOLOR}"
	sudo apt-get autoremove -y
	sudo dpkg -i *.deb
}
else {
	echo "${RED}Android${NOCOLOR}"
	apt-get autoremove -y
	dpkg -i *.deb
	termux-setup-storage
}
fi

if [ "${comp_status}" = "true" ];
then
{
	echo "${RED}Local compile${NOCOLOR}"
}
else {
	echo "${RED}Rwmote compile${NOCOLOR}"
	cd ../
	rm numb_v2 -rf

}
fi

	clear


