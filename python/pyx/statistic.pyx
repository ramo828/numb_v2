import numb_lib as nl
import json
import requests
import os.path
import math
from tqdm import tqdm
import os
import time as tm

stopFlag = True
nameFile = ""
new = ""
tip = 1
sharp = ""
conf = "default.dir"           # Export edilecek qovluq
begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
end = nl.getIndex(1)   
prefix = nl.prefixDef()                                 # Prefix deyiskeni

choise = int(input("\n\t0 - Yükləmə modu\n\t1 - Analiz modu\n>> "))

if(choise == 0):
    tip = int(input("\n\t0 - Köhnə data \n\t1 - Yeni data\n >> "))
    number = nl.quest1()                                    # Nomreni daxil edin
    nl.AI_Select()                                          # Kategoriyalari daxil edin
    prefixValue = nl.getPrCt(0)                             # Prefix melumatlarini al
    categoryKey = nl.getPrCt(1)                             # Kategoriya keyini al  
    prefix = nl.prefixDef()                                 # Prefix deyiskeni

def File(file,appendMode):
    try:
        f = open(file,appendMode)
    except FileNotFoundError:
        raise FileNotFoundError("Fayl tapılmadı")
    return f


def calcData():
    f = File("old.numb","r")
    f1 = File("new.numb","r")
    path = nl.readConfig(conf)
    yekun = File(path+"/Founded.vcf","w")
    dataNew = f1.readlines()
    dataOld = f.readlines()
    count = 0
    count1 = 0
    found = ""
    for d in tqdm(dataNew):
        if(d not in dataOld):
            count=count+1
            found +=d
    print("Tapıldı: "+str(count))
    tm.sleep(5)
    for pre in tqdm(range(0,7)):
        for dataTree in tqdm(found.splitlines()):
            nl.vcardWrite(yekun,"FContact",prefix,pre,dataTree,count1)
            count1=count1+1
    print("Tapıldı: "+str(count1))
    


def dlData():
    global sharp,new
    if(tip == 0):
        nameFile = "old.numb"
    elif(tip == 1):
        nameFile = "new.numb"
    else:
        raise NameError("Seçim mövcud deyil")    
    f = File(nameFile,"w")
    totalElements = math.ceil(nl.loadTotal(categoryKey)/2000)                 # Sehife sayi
    rawTotalElement = nl.loadTotal(categoryKey)                               # Nomre sayi
    for cevir in range(totalElements):                          # Tapilan sehifede nomreleri liste yukle
        sharp=sharp+"#"
        if(cevir+1%40 == 0):
            sharp=sharp+"\n"
        os.system("clear")
        print("Biraz gozleyin...\n")
        print("Sehife sayi: "+str(totalElements)+"\nNomre sayi: "+str(rawTotalElement))
        print(sharp)
        new +=nl.loadData(cevir)                                   # Tapilan sehifedeki umumi nomreler
    f.write(new)
    f.close()
if(choise == 0):
    dlData()
elif(choise == 1):
    calcData()
else:
    raise NameError("Xətalı seçim")
