import db as t1
import lib
import sys
import os

ddir = os.getcwd()+"/.config/"                           # Oldugun qovluq
run = ("srcpy/numb.py","srcpy/statistic.py","srcpy/robo.py")
runChoise = 0
raw = ""
regStatus = False
clear = True;

def regMetod(uuser,ppass):
    clear = True
    if(not t1.alreadyUser(uuser)):
        print("""
    \n\t##########################    
    \tQeydiyyat uğurla başa çatdı\n
    \t##########################\n
                """)
        t1.reg(uuser,ppass)
    else:
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
        elif(not clear):
            print("Siz artıq qeydiyyatdan keçmisiniz!\n")
except IndexError:
    print("Bos argument")
    runChoise = 0
try:
    r = open(ddir+"user.reg","r")
    raw = r.read()
except FileNotFoundError:
    regStatus = True
    if(not clear):
        print("Programdan istifadə üçün qeydiyyatdan keçməlisiniz!")
login = lib.spl(raw,",",0)
pswd = lib.spl(raw,",",1)
#print(login)
#print(pswd)
status = t1.checkUserAndPassword(login,pswd)
if(status):
  if(t1.checkUserStatus(login,pswd)):
    try:
        exec(open(run[runChoise]).read())
    except FileNotFoundError:
        print("Çalışdırılacaq fayl yoxdur!")
        print(os.getcwd())
  else:
    print("Login və Parol doğrudur ancaq status aktiv deyil!")
elif(not clear):
  print("Login və ya parol yanlısdır!")


