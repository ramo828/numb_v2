#__________                        _________________  ______________________
#\______   \_____    _____   ____ /   _____/\_____  \ \_   _____/\__    ___/
# |       _/\__  \  /     \ /  _ \\_____  \  /   |   \ |    __)    |    |   
# |    |   \ / __ \|  Y Y  (  <_> )        \/    |    \|     \     |    |   
# |____|_  /(____  /__|_|  /\____/_______  /\_______  /\___  /     |____|   
#        \/      \/      \/              \/         \/     \/             
############################################################################
import requests                                              # Lib
import json                                                  # Lib
import time as tm                                            # Lib
import numb_lib as nl
import os
import warnings
from tqdm import tqdm
import math
import db
############################################################################
contactName = ""
if len(nl.readConfig("contact.name")) > 0:
    contactName = nl.readConfig("contact.name") 
else:
    contactName = "Metros"
dataTwo = "";                                               # Data 2
count = 0;                                                  # Saygac
prefixValue = 0;                                            # Default deyer 0
end = 0
warnings.filterwarnings("ignore")
new_data = ""
status = db.checkUserLevel();

##############################################################################
################################AZERCELL######################################
def aRun():
    global new_data
    global count
    prefixAz = nl.getAzPrefix()
    nl.numb_run(number)
    new_data = nl.sum_data()
    for pre in range(nl.getAzBegin(),nl.getAzEnd()):
        for n in tqdm(new_data.split("\n")):
            dataFour = n
            nl.vcardWrite(w,                                # Vcard skelet
            contactName,                                    # Kontakt adi
            prefixAz,                                       # Prefix
            pre,                                            # Prefix Araligi
            dataFour,                                       # Yekun data
            count)                                          # Kontaktin ad ardicilligi
            count=count+1


##############################################################################
#################################BAKCELL######################################
def bRun():
    global count
    global end
    global dataTwo
    try:
        nl.AI_Select()                                          # Kategoriyalari daxil edin
    #prefixValue = nl.getPrCt(0)                             # Prefix melumatlarini al
        nl.numLimit()                                           # Nomre alagini daxil et
        begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
        end = nl.getIndex(1)                                    # Nomre son (araliq)
    #reverseValue = nl.getIndex(2)                           # Nomreleri deyisdir. (099 secilende 055, 055 secilende 099 elave et)
        prefix = nl.prefixDef()                                 # Prefix deyiskeni
        categoryKey = nl.getPrCt(1)                             # Kategoriya keyini al  
        lim = nl.loadTotal(categoryKey)/2000
        totalElements = math.ceil(lim)                          # Sehife sayi
        rawTotalElement = nl.loadTotal(categoryKey)             # Nomre sayi

        print("t"+str(totalElements))
        for allNumber in range(totalElements):
            os.system("clear")
            print("Biraz gozleyin...\n")
            print("Sehife sayi: "+str(totalElements)+"\nNomre sayi: "+str(rawTotalElement))
            dataTwo +=nl.loadData(allNumber)
    
        for pre in tqdm(range(begin,end)):
            for dataTree in tqdm(dataTwo.split("\n")):
                nl.vcardWrite(w,contactName,prefix,pre,dataTree,count)
                count=count+1
    except TypeError:
        print("\n\t[---Key Xətası---]")

##############################################################################
##############################APP_RUN#########################################
author_logo = nl.logo()                                 # Muellif logosu
w = nl.fileControl()                                    # config file control
print("""
    ##################################################
    --------------------------------------------------
                Created by Mammadli Ramiz
    --------------------------------------------------
    ##################################################
    """)
if(status == 1):
    print("\n\t-----------ProMod-----------\n")
    print("""
           Çalışacağınız operator: \n
            \t0 - Bakcell\n
            \t1 - Azərcell\n
	    """)

    operator = int(input(">> "))
else:
    operator = 0
if(operator == 0):
    print("\n\tBAKCELL\n")
    try:
        number = nl.quest1()                                    # Nomreni daxil edin
        db.addSeries(number)
        try:
            bRun()
        except TypeError:
            print("Key xətası")

        nl.banBegin()
        nl.banEnd(count,end)
    except (EOFError, KeyboardInterrupt):
        print("Program dəyandırıldı")
elif(operator == 1):
   azEnd = nl.getAzEnd()
   print(azEnd)
   print("\n\tAZƏRCELL\n")
   number = nl.quest1()                                    # Nomreni daxil edin
   db.addSeries(number)
   aRun()
   nl.banBegin()
   nl.banEnd(count,azEnd)
else:
   print("Bilinməyən əmr!")


##############################################################################
print(nl.readConfig(nl.getFP(0))+nl.getFP(1))
##############################################################################
