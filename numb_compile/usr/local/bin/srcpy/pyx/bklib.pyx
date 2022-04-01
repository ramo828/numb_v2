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
if len(nl.readCNConfig("contact.name")) > 0:
    contactName = nl.readConfig("contact.name") 
else:
    contactName = "Metros"
# dataTwo = "";                                               # Data 2
# count = 0;                                                  # Saygac
# prefixValue = 0;                                            # Default deyer 0
end = 0
warnings.filterwarnings("ignore")
new_data = ""
status = db.checkUserLevel()

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
        nl.setOperatorKey(0)
        nl.setCategory                                          # Kategoriyalari daxil edin
        nl.number_range()                                       # Nomre alagini daxil et
        begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
        end = nl.getIndex(1)                                    # Nomre son (araliq)
        prefix = nl.prefixDefinition()                          # Prefix deyiskeni
        categoryKey = nl.getPrefixOrCategory(1)                 # Kategoriya keyini al  
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
################################Nar###########################################
def nRun(number):
    global count
    global end
    global dataTwo
    try:
        nl.setOperatorKey(1)
        nl.setPrefix()
        nl.setPrestige()
        nl.number_range()                                       # Nomre alagini daxil et
        begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
        end = nl.getIndex(1)                                    # Nomre son (araliq)
        prefix = nl.prefixDefinition()
        dataTwo +=nl.conNar(number)
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
status = 3

if(status != 0):
    print("-------ProMode-------\n")
    if(status == 1):
        print("""
        \t 1 - Bakcell
        \t 2 - Nar
        """)
        operator = int(input(">> "))
    elif(status == 2):
        print("""
        \t 1 - Bakcell
        \t 2 - Azercell
        """)
        operator = int(input(">> "))
    elif(status == 3):
        print("""
        \t 1 - Bakcell
        \t 2 - Azercell
        \t 3 - Nar
        """)
        operator = int(input(">> "))
else:
    operator = 0

if(operator == 1 and status > 0):
    nl.setOperatorKey(0)
    print("\n\tBAKCELL\n")
    try:
        number = nl.input_number()                                    # Nomreni daxil edin
        db.addSeries(number)
        try:
            bRun()
        except TypeError:
            print("Key xətası")

        nl.bannerBegin()
        nl.bannerEnd(count,end)
    except (EOFError, KeyboardInterrupt):
        print("Program dəyandırıldı")

elif(operator == 2 and status > 1):
   azEnd = nl.getAzEnd()
   print(azEnd)
   print("\n\tAZƏRCELL\n")
   number = nl.input_number()                                    # Nomreni daxil edin
   db.addSeries(number)
   aRun()
   nl.bannerEnd()
   nl.bannerBegin(count,azEnd)

elif(operator == 3 and status > 2):
    print("\n\tNar\n")
    number = nl.input_number()                                   # Nomreni daxil edin
    db.addSeries(number)
    try:
        nRun(number)
    except TypeError:
        print("Key xətası")

    nl.bannerBegin()
    nl.bannerEnd(count,end)
else:
   print("Bilinməyən əmr!")


##############################################################################
print(nl.readConfig(nl.getFileOrPath(0))+nl.getFileOrPath(1))
##############################################################################
