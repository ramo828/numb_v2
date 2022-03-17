import db as t1
import lib
import sys
import os

ddir = os.getcwd()+"/.config/"                           # Oldugun qovluq
run = ("srcpy/numb.py","srcpy/statistic.py","srcpy/robo.py")
runChoise = 0
raw = ""
try:
    if(sys.argv[1] == "--run"):
        if(sys.argv[2] == "numb"):
            runChoise = 0
        elif(sys.argv[2] == "statistic"):
            runChoise = 1
        elif(sys.argv[2] == "robot"):
            runChoise = 2
        else:
            raise TypeError("Bilinməyən əmr!")
except IndexError:
    print("Bos argument")
    runChoise = 0
try:
    r = open(ddir+"user.reg","r")
    raw = r.read()
except FileNotFoundError:
    print("Programdan istifadə üçün qeydiyyatdan keçməlisiniz!")
login = lib.spl(raw,",",0)
pswd = lib.spl(raw,",",1)
print(login)
print(pswd)
status = t1.checkUserAndPassword(login,pswd)
if(status):
  if(t1.checkUserStatus(login,pswd)):
    try:
        exec(open(run[runChoise]).read())
    except FileNotFoundError:
        print("Çalışacaq fayl yoxdur!")
  else:
    print("Login və Parol doğrudur ancaq status aktiv deyil!")
else:
  print("Login və ya parol yanlısdır!")


