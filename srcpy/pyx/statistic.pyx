from pyparsing import Char
import numb_lib as nl
import os.path
import math
from tqdm import tqdm
import os
import time as tm
import db


stopFlag = True
nameFile = ""
new = ""
tip = 1
sharp = ""
begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
end = nl.getIndex(1)   
prefix = nl.getPrefix()                                 # Prefix deyiskeni
longData = False

nl.lightGreen();
operator = int(input("\n\t0 - Bakcell\n\t1 - Nar\n>> "))
if(operator == 0):
    nl.setOperatorKey(0)
elif(operator == 1):
    nl.setOperatorKey(1)
else:
    raise TypeError("Yanlış seçim!")


def xcount(data):
    xc = 0
    for i in range(7):
        if(data[i].lower() == 'x'):
            xc+=1
    return xc


nl.lightGreen()
choise = int(input("\n\t0 - Yükləmə modu\n\t1 - Analiz modu\n>> "))

if(choise == 0):
    tip = int(input("\n\t0 - Köhnə data \n\t1 - Yeni data\n >> "))
    number = nl.input_number()                                          # Nomreni daxil edin
    if(operator == 0):
        nl.setCategory()
    elif(operator == 1):
        if(xcount(number) > 4):
            longData = True
        nl.setPrefix()                                                  # Kategoriyalari daxil edin
        nl.setPrestige()
    else:
        raise TypeError("Xəta")                           
    prefixValue = nl.getPrefixOrCategory(0)                             # Prefix melumatlarini al
    categoryKey = nl.getPrefixOrCategory(1)

def File(file,appendMode):
    try:
        f = open(file,appendMode)
    except FileNotFoundError:
        raise FileNotFoundError("Fayl tapılmadı")
    return f


def calcData():
    f = File("old.numb","r")
    f1 = File("new.numb","r")
    yekun = File(db.getHomeDir()+"/Founded.vcf","w")
    dataNew = f1.readlines()
    dataOld = f.readlines()
    count = 0
    count1 = 0
    found = ""
    for d in tqdm(dataNew):
        if(d not in dataOld):
            count+=1
            found +=d
    nl.green()
    print("Tapıldı: "+str(count))
    tm.sleep(5)
    for pre in tqdm(range(0,7)):
        for dataTree in tqdm(found.splitlines()):
            nl.vcardWrite(yekun,"FContact",prefix,pre,dataTree,count1)
            count1=+1
    print("Tapıldı: "+str(count1))
    


def dlData():
    global sharp,new,totalElements
    longNumber = 0
    tam = 0
    qaliq = 0

    if(tip == 0):
        nameFile = "old.numb"
    elif(tip == 1):
        nameFile = "new.numb"
    else:
        raise NameError("Seçim mövcud deyil")    
    f = File(nameFile,"w")
    if(operator == 0):
        totalElements = math.ceil(nl.loadTotal(categoryKey)/2000)                 # Sehife sayi
        rawTotalElement = nl.loadTotal(categoryKey)                               # Nomre sayi
    elif(operator == 1):
        if(longData):
            nl.yellow()
            print("""
            Nömrə sayı çoxdur! Nömrə sayını
            əl ilə daxil etmək istəyirsiniz?
            Bu sizə xeyli zaman qazandıracaq.\n
            Dəvam etmək üçün Bəli(b)
            imtina etmək üçün isə Xeyr(x)
            daxil edin!
            \n
            Qeyd: sayları nöqtəli daxil etməyin!""")
            nl.lightGreen()
            ch = str(input(">> "))
            if(ch.lower() == 'b'):
                nl.magenta()
                print("Nömrə sayını daxil edin\n")
                nl.lightGreen()
                longNumber = int(input(">> "))
                tam = divmod(longNumber,2000)[0]
                qaliq = longNumber%2000
                totalElements = tam+1
                rawTotalElement = (tam*2000)+qaliq
            elif(ch.lower() == 'x'):
                totalElements = nl.narPageCount()                                         # Sehife sayi
                rawTotalElement = nl.loadNarTotal(totalElements-1)+(totalElements-1)*2000 # Nomre sayi
            else:
                raise TypeError("Xətalı daxiletmə")
    else:
        raise TypeError("Xəta")

    for cevir in range(totalElements):                          
        sharp=sharp+"#"
        if(cevir+1%40 == 0):
            sharp=sharp+"\n"
        os.system("clear")
        nl.lightGreen()
        print("Biraz gözləyin...\n")
        print("Səhifə sayı: "+str(totalElements)+"\nNömrə sayı: "+str(rawTotalElement))
        print(sharp)
        if(operator == 0):
            new +=nl.loadData(cevir)                                   # Tapilan sehifedeki umumi nomreler
        elif(operator == 1):
            new += nl.loadNarData(cevir)
        else:
            new = ""
            raise TypeError("Error")                                     # Tapilan sehifedeki umumi nomreler

    f.write(new)
    f.close()
if(choise == 0):
    dlData()
elif(choise == 1):
    calcData()
else:
    raise NameError("Xətalı seçim")
