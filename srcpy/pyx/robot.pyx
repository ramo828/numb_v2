import pyautogui as pg
import time as t
#sudo apt-get install xclip
#sudo apt-get install xsel
#sudo apt-get install wl-clipboard
import pyperclip as pc
import subprocess
import sys
import colorama
from colorama import Fore, Back, Style

contactName = "Metros"
status = 0
startTime = 10
begin = 1                                     # Baslama noqtesi (min=1)
count = 0                                     # saygac
flag =  True                                  # Bayraq
limit = 100                                   # Limit
msgSpeed = 0.0                                # Atilacaq mesajin sureti
msgIndex = 0                                  # Default mesaj sayi
binPath = ""                                  # binPath

if(subprocess.check_output(['uname', '-o']).strip() == b'Android'):
    binPath = "/data/data/com.termux/files/usr/bin/"
else:
    binPath = "/usr/local/bin/"

try:
    if(sys.argv[1] == "default"):
        status = 1
    elif(sys.argv[1] == "msg"):
        msgIndex = int(sys.argv[2])
        print(Style.RESET_ALL)
        print(Fore.LIGHTGREEN_EX)
        print("Mesaj {countMsg}".format(countMsg = msgIndex));
except IndexError:
    status = 0

if(status == 0):
    print(Style.RESET_ALL)
    print(Fore.LIGHTGREEN_EX)
    contactName = str(input("Kontakt adı: "))
    startTime = int(input("Başlama vaxtı (san): "))
    begin = int(input("Başlanğıc addım: "))
    limit = int(input("Bitiş addımı: "))
    cust = str(input("Öz mesaj faylınızla dəvam etmək üçün [H] və ya [Yes], sistem mesaji ilə dəvam etmək istəyirsinizsə [Y] və ya [No] yazıb enter'ə basın! >> ")).lower()
    if(cust == 'h' or cust == "yes"):
        msgName = str(input("Mesaj faylının adını daxil et: "))
        t.sleep(startTime)                            # Start 10 san
        try:
            msg = open(msgName,'r')
        except FileNotFoundError:
            print(Style.RESET_ALL)
            print(Fore.RED)
            print("\n Mesaj fayli tapilmadi")
    elif(cust == 'y' or cust == "no"):
        t.sleep(startTime)                            # Start 10 san
        try:
            msg = open(binPath+'message/'+str(msgIndex),'r')
        except FileNotFoundError:
            print("\n Mesaj fayli tapilmadi")
    else:
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("Xetalı emr!")

data = msg.read()
pc.copy(data)
count=count+begin                             # Saygaca baslangic deyeri elave et
while flag:
    pg.hotkey('ctrl','alt','n')               # Search contacts
    pg.write(" "+contactName, interval=0.50)  # Contact name
    print(count)                              # saygaci goster 
    if(count < 10):
        msgSpeed = 1.0
    elif(count >=10 and count <= 50):
        msgSpeed = 0.75
    elif(count >= 51 and count <= 100):
        msgSpeed = 0.50
    elif(count >= 100 and count <= 200):
        msgSpeed = 0.25
    else:
        msgSpeed = 0.15

    pg.press('down',presses=count,interval=msgSpeed)
    t.sleep(0.300)
    pg.press('enter')
    t.sleep(0.700)
    pg.hotkey('ctrl','v')
    t.sleep(0.700)
    pg.press('enter')
    t.sleep(0.200)
    if(limit == count):
        print("Limitə çatdı")
        flag = False
    count=count+1;
    
