#from msilib.schema import Error
import sys
import os
import subprocess as sp
import hashlib as hl
import time as tm
import db as t1
import numb_lib as lib
from numb_lib import AutoKey

#----------------------------------------------------------
bearerKey = dict()                                         # Key Lugeti
bearerKey["Bakcell"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJNQUlOIiwiZXhwIjoxNjQ5MzM0NzAyfQ.N2Jt28lAVMLhw4mnGJwM0QbHsEaW8c3raG-xzjufnh05uGPrJuNZvfsy8-A-M-suzpCYV-XYgBrthwui7NAadw"
bearerKey["Nar"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4MjQtMDAwMGIiLCJhdXRoIjoiSVNQLFJFQ0hBUkdFX0xPRyIsImV4cCI6MTY0ODkwNzA5Mn0.ox1r4jNdH873sBwyzZAntAn6ld0Mk1nal1nH2jst3HyVy9Vhiv9-PLGvjIRmfufAO8cRoONyae1a-qjdHfgrIA" 
#----------------------------------------------------------
defaultName = "Metros"
homeDir = "/home/ramo828/"
server = [
    ["sql11.freemysqlhosting.net","sql11505618","JivNUgpe8P","sql11505618"], # server1
    ["remotemysql.com","3KndKumGco","ViwaxpWyiD","3KndKumGco"],              # server2
]

if(sp.check_output(['uname', '-o']).strip() == b'Android'):
    binPath = "/data/data/com.termux/files/usr/bin/"
else:
    binPath = "/usr/local/bin/"

readDB = open(".config/numb_data.db","rb")
if( len(readDB.read()) > 0):
    pass
else:
    # Əgər program yenidən qurulursa default ayarlar olaraq bunları icra et!
    t1.createTable()
    t1.addSettings(bearerKey["Bakcell"],bearerKey["Nar"],defaultName,homeDir,1,0)
    t1.addServer(server[0][0],server[0][1],server[0][2],server[0][3])             #server1


try:
    if(t1.getServerNumber() == 0):
        t1.updateServer(server[0][0],server[0][1],server[0][2],server[0][3])      #server1
    elif(t1.getServerNumber() == 1):
        t1.updateServer(server[1][0],server[1][1],server[1][2],server[1][3])      #server2
except IndexError:
    lib.red()
    print("Xəta baş verdi!")


ddir = os.getcwd()+"/.config/"                           # Oldugun qovluq
run = (binPath+"srcpy/numb.py",binPath+"srcpy/statistic.py",binPath+"srcpy/robo.py")
runChoise = 0
raw = ""
regStatus = False

choise = 0
realKey = AutoKey("824-0038", "samir9995099")

if(t1.autoKey()):
    try:
        rKey = realKey.getKey()
        t1.updateGlobalKey(1, rKey)
        key = t1.updateKey(0)                                            # Bakcell
        old = t1.getKey(0)                                               # oldBakcell

        narKey = t1.updateKey(1)                                         # Nar
        narOld = t1.getKey(1)                                            # oldNar

        old_sha = hl.sha256(bytes(old,'utf-8')).hexdigest()
        new_sha = hl.sha256(bytes(key,'utf-8')).hexdigest()

        old_sha_nar = hl.sha256(bytes(narOld,'utf-8')).hexdigest()
        new_sha_nar = hl.sha256(bytes(narKey,'utf-8')).hexdigest()

        if(not (old_sha == new_sha)):
            lib.light_red()
            print("\t\t-------Ferqli kod Bakcell-------")
            t1.updateKeyLocal(key,0)
            tm.sleep(1/2)
            os.system("clear")
        elif(not (old_sha_nar == new_sha_nar)):
           
            lib.light_red()
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
        lib.light_blue()
        print("""
    \n\t##########################    
    \tQeydiyyat uğurla başa çatdı\n
    \t##########################\n
                """)
        t1.reg(uuser,ppass)
    else:
        lib.red()
        print("Bu login artıq istifadə olunur!\n")



try:
    if(sys.argv[1] == "--run"):
        if(sys.argv[2] == "numb"):
            runChoise = 0
        elif(sys.argv[2] == "statistic"):
            runChoise = 1
        # elif(sys.argv[2] == "robot"):
        #     runChoise = 2
        else:
            print("Xeta")
    elif(sys.argv[1] == "--reg"):
        if(not regStatus):
            regMetod(sys.argv[2],sys.argv[3])
        else:
            lib.red()
            print("Siz artıq qeydiyyatdan keçmisiniz!\n")

    elif(sys.argv[1] == "--updateGlobalKey"):
        if(sys.argv[2].lower() == 'bakcell'):
            choise = 0
        elif(sys.argv[2].lower() == "nar"):
            choise = 1
        else:
            choise = -1
        t1.updateGlobalKey(choise,sys.argv[3])
        tm.sleep(1)
        exit(1)

except IndexError:
    lib.red()
    print("Bos argument")
    runChoise = 0


login = t1.getUserData(0)
pswd = t1.getUserData(1)



agent = sp.check_output(["uname","-a"])
ff = t1.getHash(login,pswd)
hash = hl.sha256(agent).hexdigest()

if(hash == ff):
    pass
else:
    if(t1.checkUserAndPassword(login,pswd) and t1.checkUserStatus(login,pswd)):
        lib.red()
        print("Eyni hesaba birdən çox istifadəçi daxil olduğuna görə hesabınız bloklanıb!")
        t1.accoundBlocked(t1.getID(login, pswd))
        exit(1)

count = t1.getCounter(login,pswd)
idUser = t1.getID(login,pswd)
t1.counterAdd(idUser, count+1)

status = t1.checkUserAndPassword(login,pswd)
level = t1.checkUserLevel(login,pswd)

if(status):
  if(t1.checkUserStatus(login,pswd)):
    try:
        if(runChoise == 1):
            if(level == 3):
                exec(open(run[1]).read())
            else:
                lib.red()
                print("Siz bura daxil ola bilməzsiniz!")
        else:
            exec(open(run[runChoise]).read())
    except FileNotFoundError:
        lib.red()
        print("Çalışdırılacaq fayl yoxdur!")
        print(os.getcwd())
  else:
    lib.magenta()
    print("Login və Parol doğrudur ancaq status aktiv deyil!")
elif(login is None and pswd is None):
        lib.red()
        print("""\n
            Siz qeydiiyatdan keçməmisiniz! 
            Zəhmət olmasa qeydiyyatdan keçin.""")
else:
    lib.red()
    print("Login və ya parol yanlısdır!")


