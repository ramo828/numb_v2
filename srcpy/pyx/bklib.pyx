#__________                        _________________  ______________________
#\______   \_____    _____   ____ /   _____/\_____  \ \_   _____/\__    ___/
# |       _/\__  \  /     \ /  _ \\_____  \  /   |   \ |    __)    |    |   
# |    |   \ / __ \|  Y Y  (  <_> )        \/    |    \|     \     |    |   
# |____|_  /(____  /__|_|  /\____/_______  /\_______  /\___  /     |____|   
#        \/      \/      \/              \/         \/     \/             
############################################################################
import numb_lib as nl
import os
import warnings
from tqdm import tqdm
import math
import db


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
    nl.setAzercellPrefix()
    prefix = nl.getPrefix()                                 # Prefix deyiskeni
    nl.number_range()                                       # Nomre alagini daxil et
    begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
    end = nl.getIndex(1)                                    # Nomre son (araliq)
    nl.numb_run(number)
    new_data = nl.sum_data()
    for pre in range(begin,end):
        for n in tqdm(new_data.split("\n")):
            dataFour = n
            nl.vcardWrite(w,                                # Vcard skelet
            contactName,                                    # Kontakt adi
            prefix,                                         # Prefix
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
        nl.number_range()                                   
            # Nomre alagini daxil et
        begin = nl.getIndex(0)                                  # Nomre baslangic (araliq)
        end = nl.getIndex(1)                                    # Nomre son (araliq)
        prefix = nl.getPrefix()                                 # Prefix deyiskeni
        categoryKey = nl.getPrefixOrCategory(1)                 # Kategoriya keyini al  
        lim = nl.loadTotal(categoryKey)/2000
        totalElements = math.ceil(lim)                          # Sehife sayi
        rawTotalElement = nl.loadTotal(categoryKey)             # Nomre sayi

        print("t"+str(totalElements))
        for allNumber in range(totalElements):
            os.system("clear")
            nl.light_blue()
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
        prefix = nl.getPrefix()
        dataTwo +=nl.conNar(number)
        for pre in tqdm(range(begin,end)):
            for dataTree in tqdm(dataTwo.split("\n")):
                nl.vcardWrite(w,contactName,prefix,pre,dataTree,count)
                count=count+1
        nl.bannerBegin()
        nl.bannerEnd(count,end)

    except TypeError:
        nl.red()
        print("\n\t[---Key Xətası---]")


##############################################################################
##############################APP_RUN#########################################
author_logo = nl.logo()                                 # Muellif logosu
w = nl.fileControl()                                    # config file control
nl.magenta()
print("""
    ##################################################
    --------------------------------------------------
                Created by Mammadli Ramiz
    --------------------------------------------------
    ##################################################
    """)
###################################################################

if(status != 0):
    nl.light_black()
    print("\t\t-------ProMode-------\n")
    if(status == 1):
        nl.lightGreen()
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
        nl.lightGreen()
        print("""
        -------------------------------------\n
        \t 1 - Bakcell
        -------------------------------------\n
        \t 2 - Azercell
        -------------------------------------\n
        """)
        operator = int(input(">> "))
    elif(status == 3):
        nl.lightGreen()
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
    nl.light_magenta()
    print("\n\tBAKCELL\n")
    number = nl.input_number()                                   # Nomreni daxil edin
    try:
        db.addSeries(number)
        try:
            bRun()
        except TypeError:
            nl.red()
            print("Key xətası")

    except (EOFError, KeyboardInterrupt):
        nl.red()
        print("Program dəyandırıldı")

elif(operator == 2 and status >= 2):
   nl.light_magenta()
   print(nl.getIndex(1))
   print("\n\tAZƏRCELL\n")
   number = nl.input_number()                                    # Nomreni daxil edin
   db.addSeries(number)
   aRun()

elif(operator == 3 and status > 0):
    nl.light_magenta()
    print("\n\tNar\n")
    number = nl.input_number()                                   # Nomreni daxil edin
    db.addSeries(number)
    try:
        nRun(number)
    except TypeError:
        nl.red()
        print("Key xətası")

elif(operator == 0):
    pass
else:
    nl.red()
    print("Bilinməyən əmr!")


##############################################################################
nl.light_black()
print(db.getHomeDir()+nl.getFileOrPath(1))
##############################################################################
