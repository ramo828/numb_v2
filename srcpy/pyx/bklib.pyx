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
import colorama
from colorama import Fore, Back, Style

############################################################################
contactName = db.getName()

dataTwo = "";                                               # Data 2
count = 0;                                                  # Saygac
prefixValue = 0;                                            # Default deyer 0
end = 0
warnings.filterwarnings("ignore")
new_data = ""
status = db.checkUserLevel(db.getUserData(0),db.getUserData(1))
number = ""
operator = 0

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
    nl.bannerBegin()
    nl.bannerEnd(count,end)



##############################################################################
#################################BAKCELL######################################
def bRun():
    global count
    global end
    global dataTwo
    try:
        nl.setOperatorKey(0)
        os.system("clear")
        nl.setCategory()                                        # Kategoriyalari daxil edin
        number = nl.input_number()                              # Nomreni daxil edin
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
            print(Style.RESET_ALL)
            print(Fore.LIGHTBLUE_EX)
            print("Biraz gozleyin...\n")
            print("Sehife sayi: "+str(totalElements)+"\nNomre sayi: "+str(rawTotalElement))
            dataTwo +=nl.loadData(allNumber)
    
        for pre in tqdm(range(begin,end)):
            for dataTree in tqdm(dataTwo.split("\n")):
                nl.vcardWrite(w,contactName,prefix,pre,dataTree,count)
                count=count+1
        nl.bannerBegin()
        nl.bannerEnd(count,end)

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
        nl.bannerBegin()
        nl.bannerEnd(count,end)

    except TypeError:
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("\n\t[---Key Xətası---]")


##############################################################################
##############################APP_RUN#########################################
author_logo = nl.logo()                                 # Muellif logosu
w = nl.fileControl()                                    # config file control
print(Style.RESET_ALL)
print(Fore.MAGENTA)
print("""
    ##################################################
    --------------------------------------------------
                Created by Mammadli Ramiz
    --------------------------------------------------
    ##################################################
    """)
###################################################################

if(status != 0):
    print(Style.RESET_ALL)
    print(Fore.LIGHTBLACK_EX)
    print("\t\t-------ProMode-------\n")
    if(status == 1):
        print(Style.RESET_ALL)
        print(Fore.LIGHTGREEN_EX)
        print("""
        -------------------------------------\n
        \t 1 - Bakcell
        -------------------------------------\n
        \t 2 - Nar
        -------------------------------------\n
        """)
        operator = int(input(">> "))
        if(operator == 2):
            operator =3
    elif(status == 2):
        print(Style.RESET_ALL)
        print(Fore.LIGHTGREEN_EX)
        print("""
        -------------------------------------\n
        \t 1 - Bakcell
        -------------------------------------\n
        \t 2 - Azercell
        -------------------------------------\n
        """)
        operator = int(input(">> "))
    elif(status == 3):
        print(Style.RESET_ALL)
        print(Fore.LIGHTGREEN_EX)
        print("""
        -------------------------------------\n
        \t 1 - Bakcell
        -------------------------------------\n
        \t 2 - Azercell
        -------------------------------------\n
        \t 3 - Nar
        -------------------------------------\n
        """)
        operator = int(input(">> "))
else:
    bRun()
    operator = 0

#########################################################################

if(operator == 1 and status >= 0):
    nl.setOperatorKey(0)
    print(Style.RESET_ALL)
    print(Fore.LIGHTMAGENTA_EX)
    print("\n\tBAKCELL\n")
    try:
        db.addSeries(number)
        try:
            bRun()
        except TypeError:
            print(Style.RESET_ALL)
            print(Fore.RED)
            print("Key xətası")

    except (EOFError, KeyboardInterrupt):
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("Program dəyandırıldı")

elif(operator == 2 and status >= 2):
   azEnd = nl.getAzEnd()
   print(Style.RESET_ALL)
   print(Fore.LIGHTMAGENTA_EX)
   print(azEnd)
   print("\n\tAZƏRCELL\n")
   number = nl.input_number()                                    # Nomreni daxil edin
   db.addSeries(number)
   aRun()

elif(operator == 3 and status > 0):
    print(Style.RESET_ALL)
    print(Fore.LIGHTMAGENTA_EX)
    print("\n\tNar\n")
    number = nl.input_number()                                   # Nomreni daxil edin
    db.addSeries(number)
    try:
        nRun(number)
    except TypeError:
        print(Style.RESET_ALL)
        print(Fore.RED)
        print("Key xətası")

elif(operator == 0):
    pass
else:
    print(Style.RESET_ALL)
    print(Fore.RED)
    print("Bilinməyən əmr!")


##############################################################################
print(Style.RESET_ALL)
print(Fore.LIGHTBLACK_EX)
print(db.getHomeDir()+nl.getFileOrPath(1))
##############################################################################
