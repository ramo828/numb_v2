import sys
import os
import subprocess
import hashlib
import time as tm
import db as t1
import numb_lib as lib
import colorama
from colorama import Fore, Back, Style

#----------------------------------------------------------
bearerKey = dict()                                         # Key Lugeti
bearerKey["Bakcell"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJNQUlOIiwiZXhwIjoxNjQ5MzM0NzAyfQ.N2Jt28lAVMLhw4mnGJwM0QbHsEaW8c3raG-xzjufnh05uGPrJuNZvfsy8-A-M-suzpCYV-XYgBrthwui7NAadw"
bearerKey["Nar"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4MjQtMDAwMGIiLCJhdXRoIjoiSVNQLFJFQ0hBUkdFX0xPRyIsImV4cCI6MTY0ODkwNzA5Mn0.ox1r4jNdH873sBwyzZAntAn6ld0Mk1nal1nH2jst3HyVy9Vhiv9-PLGvjIRmfufAO8cRoONyae1a-qjdHfgrIA" 
#----------------------------------------------------------
defaultName = "Metros"
homeDir = "/home/ramo828/"

colorama.init()

if(subprocess.check_output(['uname', '-o']).strip() == b'Android'):
    binPath = "/data/data/com.termux/files/usr/bin/"
else:
    binPath = "/usr/local/bin/"

readDB = open(".config/numb_data.db","rb")
if( len(readDB.read()) > 0):
    pass
else:
    t1.createTable()
    t1.addSettings(bearerKey["Bakcell"],bearerKey["Nar"],defaultName,homeDir,1)

ddir = os.getcwd()+"/.config/"                           # Oldugun qovluq
run = (binPath+"srcpy/numb.py",binPath+"srcpy/statistic.py",binPath+"srcpy/robo.py")
runChoise = 0
raw = ""
regStatus = False


if(t1.autoKey()):
    try:
        key = t1.updateKey(0)                                            # Bakcell
        old = t1.getKey(0)                                               # oldBakcell

        narKey = t1.updateKey(1)                                         # Nar
        narOld = t1.getKey(1)                                            # oldNar

        old_sha = hashlib.sha256(bytes(old,'utf-8')).hexdigest()
        new_sha = hashlib.sha256(bytes(key,'utf-8')).hexdigest()

        old_sha_nar = hashlib.sha256(bytes(narOld,'utf-8')).hexdigest()
        new_sha_nar = hashlib.sha256(bytes(narKey,'utf-8')).hexdigest()

        if(not (old_sha == new_sha)):
            print(Fore.RED)
            print("\t\t-------Ferqli kod Bakcell-------")
            t1.updateKeyLocal(key,0)
            tm.sleep(1/2)
            os.system("clear")
        elif(not (old_sha_nar == new_sha_nar)):
            print(Fore.RED)
            print("\t\t-------Ferqli kod Nar-------")
            t1.updateKeyLocal(narKey,1)
            tm.sleep(1/2)
            os.system("clear")
        else:
            # print("Duz")
            os.system("clear")

    except TypeError:
        os.system("clear")


def regMetod(uuser,ppass):
    if(not t1.alreadyUser(uuser)):
        print(Style.RESET_ALL)
        print(Fore.BLUE)
        print("""
    \n\t##########################    
    \tQeydiyyat uğurla başa çatdı\n
    \t##########################\n
                """)
        t1.reg(uuser,ppass)
    else:
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("Bu login artıq istifadə olunur!\n")



try:
    if(sys.argv[1] == "--run"):
        if(sys.argv[2] == "numb"):
            runChoise = 0
        elif(sys.argv[2] == "statistic"):
            runChoise = 1
        elif(sys.argv[2] == "robot"):
            runChoise = 2
        else:
            print("Xeta")
    elif(sys.argv[1] == "--reg"):
        if(not regStatus):
            regMetod(sys.argv[2],sys.argv[3])
        else:
            print(Style.RESET_ALL)
            print(Fore.RED)
            print("Siz artıq qeydiyyatdan keçmisiniz!\n")
except IndexError:
    print(Style.RESET_ALL)
    print(Fore.RED)
    print("Bos argument")
    runChoise = 0


login = t1.getUserData(0)
pswd = t1.getUserData(1)

status = t1.checkUserAndPassword(login,pswd)
if(status):
  if(t1.checkUserStatus(login,pswd)):
    try:
        exec(open(run[runChoise]).read())
    except FileNotFoundError:
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("Çalışdırılacaq fayl yoxdur!")
        print(os.getcwd())
  else:
    print(Style.RESET_ALL)
    print(Fore.MAGENTA)
    print("Login və Parol doğrudur ancaq status aktiv deyil!")
elif(login is None and pswd is None):
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("""\n
            Siz qeydiiyatdan keçməmisiniz! 
            Zəhmət olmasa qeydiyyatdan keçin.""")
else:
    print(Style.RESET_ALL)
    print(Fore.RED)
    print("Login və ya parol yanlısdır!")


