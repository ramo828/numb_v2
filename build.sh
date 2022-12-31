# !/bin/dash
clear
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
WHITE='\033[0;38m'
name="numb_compile"
DEB_NAME="numb"
DEB_VERSION=2.7.0
PYTHON_SRC="srcpy"
RED='\033[0;31m'
OS="GNU/Linux"
DIST="Arch Linux"
if [ "$(uname -o)" = "$OS" ];
then
{
	if [ "$(egrep '^(VERSION|NAME)=' /etc/os-release | cut -d '"' -f 2)" = "$DIST" ];
	then {
		ArchLinux="1"
		echo "${RED}Arch Linux${NOCOLOR}"
		BINPATH="usr/local/bin" 
		sudo pacman -Syu
		sudo pacman -S curl clang zip git make libxslt cmake -y
	}
else {	
		ArchLinux="0"
		echo "${RED}Other Linux distro${NOCOLOR}"
		BINPATH="usr/local/bin"
		sudo apt-get update && sudo apt-get full-upgrade -y
		sudo apt-get install curl clang zip git make libxslt cmake -y
}
fi
	WHITE='\033[0;32m'
	GREEN='\033[0;38m'
	echo "${WHITE}"
	echo "${NOCOLOR}"
}
else {
	ArchLinux="0"
	echo "${RED}Android${NOCOLOR}"
	BINPATH="data/data/com.termux/files/usr/bin"
	echo "${GREEN}"
	yes | pkg upgrade
	yes | pkg install curl clang zip python git make libxslt cmake
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
echo "${GREEN}Lazım olan fayllar yuklənir"
sleep 1;
echo "${GREEN}Biraz gözləyin"
sleep 1;
echo "${YELLOW}Yüklənən fayllar təmizlənir...${NOCOLOR}"
sleep 2
echo "${GREEN}"
while getopts l: flag
do
    case "${flag}" in
        l) comp_status=${OPTARG};;
    esac
done
if [ "${comp_status}" = "true" ];
then
{
	echo "${YELLOW}Local compile${NOCOLOR}"
}
else {
	echo "${YELLOW}Remote compile${NOCOLOR}"
	rm numb_v2 -rf
	git clone https://github.com/ramo828/numb_v2.git
	cd numb_v2
}
fi
# 1ci merhele
echo $BINPATH
echo "${YELLOW}Sistem Təmizlənir..."
# Eger onceden yaradilibsa il
rm $name -rf
echo "Qovluq yaradılır..."
sleep 1
# yardimci qovlugu yarat
mkdir -p $name/$BINPATH
echo "Əsas fayllar kopyalanır"
# pyhon kodlarini ve mesajlari yardimci qovluga gonder
cp $PYTHON_SRC $name -r
echo "Cython compile edilir${NOCOLOR}"
# yardimci qovluqdaki python qovluguna daxil ol
cd $name/$PYTHON_SRC/
echo "${GREEN}"
# python kodlarini compile et
python "setup.py" build_ext --inplace
echo "${NOCOLOR}"
echo "${YELLOW}C++ compile edilir${NOCOLOR}"
# esas kod qovluguna qayit
cd ../../
# Logo
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
# Cmake calisdir
cmake .
# Core sayina gore c++ compile et
make -j$(nproc)
# numb faylini yardimci qovluqdaki OS path at
mv numb $name/$BINPATH
echo "---numb $name/$BINPATH---"
# Yardimci qovluga daxil ol
cd $name
# Yardimci qovlugdaki python kodlarini OS path'a at
mv $PYTHON_SRC $BINPATH
echo "${YELLOW}Lazımsız fayllar təmizlənir"
# Esak kod qovluguna geri dom
cd ../
echo "Lazımlı paketlər yüklənir${NOCOLOR}"
# Pip ve setuptools guncelle
pip install --upgrade pip setuptools
pip install --upgrade pip
sleep 1;
echo "${YELLOW}Xəta baş verərsə kodu yenidən çalışdırın"
sleep 3
# yaradilmis lazimsiz fayllari sil
rm cmake_install.cmake build CMakeFiles CMakeCache.txt -rf
sleep 1
echo "Python paketl¿ri yukl¿nir...${NOCOLOR}"
# Lazim olan python kitabxanalarini yukle
pip install -r requirements.txt
sleep 1
echo "${YELLOW}Deb faylı hazırlanır${NOCOLOR}"
if [ "$ArchLinux" = "0" ]; 
then {
	echo "Debian based"
# DEB fayli hazirla
	mkdir -p $name/DEBIAN/
	touch $name/DEBIAN/control
	chmod -R 0755 $name
	echo "Package: $DEB_NAME" >> $name/DEBIAN/control
	echo "Version: $DEB_VERSION" >> $name/DEBIAN/control
	echo "Architecture: all" >> $name/DEBIAN/control
	echo "Maintainer: RamoSoft <illegalism666@gmail.com>" >> $name/DEBIAN/control
	echo "Description: Bakcell && Azercell Tools" >> $name/DEBIAN/control
	echo " Programin esas məqsədi nömrə satışı zamanı mümkün qədər vaxta qənaət etməkdir" >> $name/DEBIAN/control
	#umask 22
	dpkg-deb --build --root-owner-group $name
	rm -rf CMakeFiles CMakeCache.txt srcpy/*.o  srcpy/pyx/*.c Makefile cmake_install.cmake
	sleep 2
}
else {
# Arch linux
echo "Arch based" 
}
     
fi
# Emeliyyat sistemine gore
if [ "$(uname -o)" = "$OS" ];
then
{
	if [ "$ArchLinux" = "1" ];
	then {
	echo "${RED}Linux${NOCOLOR}"
	echo "Compile edilir ve qurulur!"	
	makepkg -si	
	echo "Lazımsız fayllar silinir."
	rm numb_compile pkg src *.tar.zst -rf
	}
	else {
	echo "Debian based"
	echo "${RED}Linux${NOCOLOR}"
	sudo apt-get autoremove -y
	sudo dpkg -i *.deb
	}
	fi
	
}
else {
	echo "${RED}Android${NOCOLOR}"
	apt-get autoremove -y
	dpkg -i *.deb
	termux-setup-storage
}
fi
clear
echo "Hazırlanır"
sleep 1
if [ "${comp_status}" = "true" ];
then
    {
	echo "${RED}Local compile${NOCOLOR}"
	}
else {
	echo "${RED}Rwmote compile${NOCOLOR}"
	# uzaqdan endirilecekse geri don ve esas kod qovlugunu sil
	}
fi
clear
#echo "\n--------------Program versiyası\n--------------"
sleep 1
clear
echo "Yükləmə tamamlandı !"

