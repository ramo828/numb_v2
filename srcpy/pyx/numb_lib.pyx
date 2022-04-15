import os.path                                             # Lib
import os
import time as tm
import requests
from bs4 import BeautifulSoup as soup
import json
import random
import db
from colorama import Fore, Back, Style

#----------------------------------------------------------
url = dict()                                               # URL lugeti
url["Bakcell"] = "https://public-api.azerconnect.az/msbkcposappreservation/api/freemsisdn-nomre/search"
url["Azercell"] = "https://azercellim.com/az/search/"
url["Nar"] = "https://public-api.azerconnect.az/msazfposapptrans/api/msisdn-search" 

dirs = os.getcwd()+"/.config/"                             # Oldugun qovluq
fileName = "/Ramo_SOFT_all_Contacts.vcf"                   # Export edilecek kintakt fayli
prefixValue = 0
categoryKey = "sadə"
begin = 0                                                  # Baslangic 
end = 0                                                    # Son
dataVcard = [
 "BEGIN:VCARD\n"
,"N:","FN:"
,"TEL;TYPE=WORK,MSG:"
,"EMAIL;TYPE=INTERNET:\n"
,"END:VCARD\n"]
category = dict()
categoryKey = "sadə";                                      # Sade Nomreleri
category["sadə"] = "1429263300716842758";                  # Sade key
category["xüsusi1"] = "1579692503636523114";               # Xususi1 key
category["xüsusi2"] = "1579692547752973099";               # Xususi2 key
categoryKey055 = "sadə"                                    # 099 sade nomreler
#------------------099----------------------------
category["sadə099"] = "1574940031138475856";               # Sade key
category["bürünc"] = "1582551518546595643";                # Burunc key
category["gümüş"] = "1582551485948558941";                 # Gumus key
category["qızıl"] = "1582551461421619154";                 # Qizil key
category["platin"] = "1582551437850968791";                # Platin key
categoryKey099 = "bürünc"                                  # Buruc nomreler
prefixSel = ["55","99"]
number = "xxxxx"
azercellIndex = 3                                          # 010 nomre
azercellPrefix = ["90","50","51","10"]                     # Prefix var
prefixNar = "70"
sizeNar = 10000
prestige = "PRESTIGE"
bKeyDefault = ""
prefix = []

ssl = False
h = {"accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
     "accept-encoding":"gzip, deflate, br",
     "accept-language":"tr-TR,tr;q=0.9,az-TR;q=0.8,az;q=0.7,en-US;q=0.6,en;q=0.5",
     "cache-control":"max-age=0",
     "content-length":"65",
     "content-type":"application/x-www-form-urlencoded",
     "dnt":"1",
     "user-agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36"
           }


narCounter = 0
narNumber = ""
key = ""
#-------------------------------------------------

##################################GLOBAL_DATA############################################################

def magenta():
    print(Style.RESET_ALL)
    print(Fore.MAGENTA)

def light_magenta():
    print(Style.RESET_ALL)
    print(Fore.LIGHTMAGENTA_EX)

def lightGreen():
    print(Style.RESET_ALL)
    print(Fore.LIGHTGREEN_EX)

def red():
    print(Style.RESET_ALL)
    print(Fore.RED) 

def light_red():
    print(Style.RESET_ALL)
    print(Fore.LIGHTRED_EX)

def yellow():
    print(Style.RESET_ALL)
    print(Fore.YELLOW)

def light_blue():
    print(Style.RESET_ALL)
    print(Fore.LIGHTBLUE_EX)

def light_black():
    print(Style.RESET_ALL)
    print(Fore.LIGHTBLACK_EX)

def getPrefix():
    prefix.append("+99450")
    prefix.append("+99451")
    prefix.append("+99410")
    prefix.append("+99455")
    prefix.append("+99499")
    prefix.append("+99470")
    prefix.append("+99477")
    prefix.append("+99460")
    return prefix
    


def setOperatorKey(operator):
    global key
    if(operator == 0):
        key = db.getKey(0)
    elif(operator == 1):
        key = db.getKey(1)
    else:
        raise TypeError("Xetali secim")
    
    # return key

def setHeader(opcode):
    headers = {'content-type': 'application/json',         # Content type json
    'Accept':'application/json, text/plain, */*',          # Accept type json
    'Accept-Encoding':'gzip, deflate, br',                 # Encoding gzip compressed data
    'Accept-Language':'tr-TR,tr;q=0.9,az-TR;q=0.8,az;q=0.7,en-US;q=0.6,en;q=0.5',
     'Authorization': key,
    'Connection':'keep-alive'}
    return headers

def conv_numeric(counter):                                 # kontakt adlarinin sonuna a,b,c,d,e,f artirir
    sonluq = ["a","b","c","d","e","f"]
    clone = ""
    for i in range(counter):
        if(i<10):
            clone = "_"+sonluq[0]+str(i)
        elif(i<100):
            clone = "_"+sonluq[1]+str(i)
        elif(i<1000):
            clone = "_"+sonluq[2]+str(i)
        elif(i<10000):
            clone = "_"+sonluq[3]+str(i)
        elif(i<100000):
            clone = "_"+sonluq[4]+str(i)
        elif(i<1000000):
            clone = "_"+sonluq[5]+str(i)

    return clone

def input_number():
    err = 0;                                                   # Xeta
    try:
        magenta()
        print(""""
        -----------------------------------------------
        Nömrə kombinasiyasını daxil edin və boş xanalari
        x ilə tamamlayın.
        Məs: 83027xx
        -----------------------------------------------
        """)
        global number
        
        while (len(number) <7):
            if(err > 0):
                red()
                print("""
                ------------------------------
                Nömrə düzgün qeyd edilməyib
                ------------------------------
                """)    
            err=err+1;
            print(Style.RESET_ALL+Fore.GREEN)
            number = str(input(">> "))                                      # Sual 1   
        return number 
    except (TypeError):
        raise("Xətalı daxiletmə")

def fileControl():
    author_logo = logo()
    if(os.path.isdir(".config/")):
        try:
            w = open(db.getHomeDir()+fileName,"w")
        except FileNotFoundError:
            os.system("clear")
            red()
            print("Göstərilən adres mövcud deyil\n"+db.getHomeDir()+"\n")
            exit(1)
        finally:
            print(author_logo)
        return w
    else:
        light_red()
        print("Ayarlar mövcud deyildi ancaq yeniden yaradılacaq\n Təkrar programa daxil olun!")
        try:
            os.mkdir(".config")
        except FileExistsError:
            pass

def getFileOrPath(index):
    if(index == 1):                                                           # 1 daxil edilende fayl adini qaytar
        return fileName
    else:
        return "Error"

def bannerBegin():
    print(Style.RESET_ALL+Fore.GREEN+"\n\tMəlumatlar serverdən alınır")
    tm.sleep(1/1.5)
    print("\n\tMəlumatlar işlənir")
    tm.sleep(1/1.5)
def bannerEnd(count,end):
    print("\n\tKontakt Hazırlanır")
    tm.sleep(1/1.5)
    print("\n\tKontaktlar Hazırdır")
    print("""
    ------------------------------------------
    Kontaktların sayı: \033[1;32;40m"""+ str(count)+"""\033[0m""")
    print(Style.RESET_ALL+Fore.GREEN+"""
    ------------------------------------------""")
    try:
        print("""
    Tapılan nomrə sayı: \033[1;32;40m"""+ str(count/end)+"""\033[0m""")
        print(Style.RESET_ALL+Fore.GREEN+"""
    ------------------------------------------
        """)
    except ZeroDivisionError:
        pass

def vcardWrite(w,contactName,prefix,prefixAraligi,nomreler,count1):
    w.write(
    dataVcard[0]
	+dataVcard[1]+contactName+conv_numeric(count1)+"\n"	
	+dataVcard[2]+contactName+conv_numeric(count1)+"\n"
	+dataVcard[3]+prefix[prefixAraligi]+nomreler[2:9]+"\n"
	+dataVcard[4]
	+dataVcard[5])


def getPrefixOrCategory(index):
    if(index == 0):
        return prefixValue
    elif(index == 1):
        return categoryKey


def opName():

    opr = []
    opr.append("\t-------------------------------------\n")
    opr.append("\t 1) Azərcell  (050)")
    opr.append("\t 2) Azərcell  (051)")
    opr.append("\t 3) Azərcell  (010)")
    opr.append("\t 4) Bakcell   (055)")
    opr.append("\t 5) Bakcell   (099)")
    opr.append("\t 6) Nar       (070)")
    opr.append("\t 7) Nar       (077)")
    opr.append("\t 8) Naxtell   (066)")
    opr.append("\t 0) Hamısı         ")
    opr.append("\t (Nümunə: 1:3) (Azərcell-dən Bakcell-ə qədər)")
    opr.append("\t (Nümunə: 1;4;6) (Azərcell(050), Bakcell(055) və Nar(077))")
    opr.append("\t-------------------------------------\n")

    for i in range(len(opr)):
        print(opr[i]+"")

def countChar(chara):
    count1 = 0;
    for i in chara.split(';'):
        count1 +=1
    return count1

def select_prefix(msg):
    count2 = 0
    test = getPrefix()
    tip1 = []
    tip = 0
    chc = countChar(msg)
    try:
        for i in range(chc):
            tip1.append(test[int(msg[tip])-1])
            count2 +=1
            tip+=2
        return tip1
    except IndexError:
        print("Xətalı daxiletmə!")

def number_range():
    global end                                            # end deyisenini global et
    global begin
    global prefix
    temp_data = ""
    magenta()                                             # Magenta reng
    print("""\n
    \t ----Operator aralığını daxil edin----
    """)
    lightGreen()
    opName()
    rawData = str(input(">> "))                           # Alinacaq deger
    noRawData = ""

    if(not rawData.isnumeric()):
        if(not rawData.find(";") < 0):                    # ; simvolunu tap
            temp_data = select_prefix(rawData)            # tamper data
            end = len(temp_data)                          # uzunlugunu tap
            prefix = temp_data                            # prefix deyisenine elave et

    if(not rawData.isnumeric()):                          # Eger int degeri degilse
        if(not rawData.find(":") < 0):                    # : simvolunu tap
            noRawData = rawData.split(":")                # : simvolunu parcala
            begin = int(noRawData[0])-1                   # : simvolundan bir simvol ireli get ve int'e cevir
            end = int(noRawData[1])                       # : simvolundan bir addim ireli cek ve int'e cevir
            if(begin > end):                              # begin end degerinden boyukdurse
                raise TypeError("Birinci ədəd ikinci ədəddən böyük ola bilməz!")
    
  
    elif(int(rawData) == 0):                          # Eger 0 secilibse butun prefixleri sec
        begin = 0
        end = 8
    else:
        red()
        print("Xəta baş verdi")


def getIndex(index):
    if(index == 0):
        return begin
    elif(index == 1):
        return end
    else:
        return "ERROR"



#################################BAKCELL########################################
def setCategory():
    global categoryKey
    global prefixValue
    lightGreen()
    print("""
        -------------------------------------\n
    """)
    magenta()
    print("\t\tPrefix: ")
    lightGreen()
    print("""
    \t\t0 - 55\n
    \t\t1 - 99\n
        -------------------------------------\n
    """)
    prefixValue = int(input(">> "));              # Sual 2 055 yoxsa 099?
    if(prefixSel[prefixValue] == "55"):
        lightGreen()
        print("""
        -------------------------------------\n
        """)
        magenta()
        print("""
        \tKategoriya seç: \n""")
        lightGreen()
        print("""
        0 - Sadə\n
        1 - Xüsusi1\n
        2 - Xüsusi2\n
        -------------------------------------""")
        cat = int(input(">> "));                                        # Sual 3
        if(cat == 0):
            categoryKey = "sadə"
        elif(cat == 1):
            categoryKey = "xüsusi1"
        elif(cat == 2):
            categoryKey = "xüsusi2"
        else:
            red()
            print("""
            ----------------
            Xətalı seçim
            ----------------
            """)
    elif(prefixSel[prefixValue] == "99"):
        magenta()
        print("""
        -------------------------------------\n
        \tKategoriya seç\n""")
        lightGreen()
        print("""
        0 - Sadə\n
        1 - Bürünc\n
        2 - Gümüş\n
        3 - Qızıl\n
        4 - Platin
        -------------------------------------
        """)
        cat = int(input(">> "))     
        if(cat == 0):
            categoryKey = "sadə099"
        elif(cat == 1):
            categoryKey = "bürünc"
        elif(cat == 2):
            categoryKey = "gümüş"
        elif(cat == 3):
            categoryKey = "qızıl"
        elif(cat == 4):
            categoryKey = "platin"
        else:
            red()
            print("""
            ------------------
            Xətalı seçim
            -------------------
            """)
    else:
            red()
            print("""
            -------------------
            Xətalı seçim
            -------------------
            """)
    

def conBakcell(page):
    r = requests.get(url["Bakcell"], params={"prefix":prefixSel[prefixValue],
    "msisdn":number,                                        # Nomre datasi
    "categoryId":category[categoryKey],                     # Kategorya
    "showReserved":"true",                                  # Sifaris verilenler
    "size":"2000",                                          # Maksimum nomre sayi
    "page":page},                                           # Maksimum sehife sayi
    headers=setHeader(0))                                   # Header
    return r

def getConMaxData(catValKey):
    r = requests.get(url["Bakcell"], params={"prefix":prefixSel[prefixValue],
    "msisdn":number,                                        # Nomre datasi
    "categoryId":category[catValKey],                       # Kategorya
    "showReserved":"true",                                  # Sifaris verilenler
    "size":"2000",                                          # Maksimum nomre sayi
    "page":"0"},                                            # Maksimum sehife sayi
    headers=setHeader(0))                                   # Header
    return r

###################################BakcellStatistic###################################
def loadTotal(categoryKeyLocal):
    totalNumb = 0
    try:
        r = conBakcell(categoryKeyLocal)
        totalJSON = json.loads(r.text);
        for tData in totalJSON:
            totalNumb = int((tData["totalElements"]))
        return totalNumb
    except TypeError:
        red()
        print("Key xətalıdır!")


def loadData(page):
    r = conBakcell(page)
    dataFour = ""
    dataTwo = ""
    data = json.loads(r.text);
    for i in data:
        dataTwo = (i["freeMsisdnList"])
    for i2 in dataTwo:
        dataFour = dataFour+str(i2["msisdn"])+"\n"
    return dataFour

###############################AZERCELL##################################################
gozleme = 1/50;                                        # Data alma zamani
sum_d = ""

def sum_data():
   return sum_d
def extractData(number,page):
   num = [number[0],                                     # Split part1                                  
   number[1],number[2],                                  # Split part2 
   number[3],number[4],                                  # Split part3
   number[5],number[6]]                                  # Split part4
   p = {
   "num1":num[0],                                        # Number Splitter 1
   "num2":num[1],                                        # Number Splitter 2
   "num3":num[2],                                        # Number Splitter 3
   "num4":num[3],                                        # Number Splitter 4
   "num5":num[4],                                        # Number Splitter 5
   "num6":num[5],                                        # Number Splitter 6
   "num7":num[6],                                        # Number Splitter 7
   "prefix":azercellPrefix[azercellIndex],               # Prefix
   "send_search":"1"}                                    # Page
   
   r = requests.post(url["Azercell"]+str(page),data=p,verify=ssl,headers=h)    # Request Send
   source = soup(r.content,"lxml")
   find = source.findAll("div", attrs={"class":"phonenumber"})
   return find

def soupData(find):
   rawData = ""
   for findData in find:
      rawData=rawData +"\n"+str(findData.text).replace("\n","")
   return rawData

def numb_run(number):
   global sum_d
   stopFlag = True
   count_num = 1
   loading_bar = ""
   dot = ""
   dot_count = 0
   while(stopFlag):
      tm.sleep(gozleme)
      find = extractData(number,count_num)
      sp = soupData(find)
      if(len(sp) == 0):
         if(count_num == 1 and len(sp) == 0):
            light_red()
            print("Melumat yoxdur")
         lightGreen()
         print("Səhifə sayı: "+str(count_num-1))
         stopFlag = False
      else:
         if(dot_count != 3):
            dot=dot+"."
         else:
            dot_count = 0
            dot = ""
         loading_bar=loading_bar+"#"
         if(count_num%25 == 0):
            loading_bar=loading_bar+"\n"
         os.system("clear")
         lightGreen()
         print("Biraz gözləyin"+dot)
         print(loading_bar)
         sum_d=sum_d+str(sp)
      dot_count = dot_count +1
      count_num=count_num+1
    


#####################NAR##########################
def setPrefix():
    global prefixNar
    lightGreen()
    print("""
    -------------------------------------\n
    \tPrefix seç: \n
    \t070 - 0\n
    \t077 - 1\n
    --------------------------------------
    """)
    narPref = int(input(">> "))
    if(narPref == 0):
        prefixNar = "70"
    elif(narPref == 1):
        prefixNar = "77"

def setPrestige():
    global prestige
    lightGreen()
    print("""
    -------------------------------------\n
    \tKategoriya seç: \n
    \t1 - Prestige0\n
    \t2 - Prestige1\n
    \t3 - Prestige2\n
    \t4 - Prestige3\n
    \t5 - Prestige4\n
    \t6 - Prestige5\n
    \t7 - Prestige6\n
    \t8 - Prestige7\n
    \t9 - General \n
    \t0 - Hamısı\n
    -------------------------------------
    """)
    catNar = int(input(">> "))
    if(catNar == 0):
        prestige = ""
    elif(catNar == 1):
        prestige = "PRESTIGE"
    elif(catNar == 2):
        prestige = "PRESTIGE1"
    elif(catNar == 3):
        prestige = "PRESTIGE2"
    elif(catNar == 4):
        prestige = "PRESTIGE3"
    elif(catNar == 5):
        prestige = "PRESTIGE4"
    elif(catNar == 6):
        prestige = "PRESTIGE5" 
    elif(catNar == 7):
        prestige = "PRESTIGE6" 
    elif(catNar == 8):
        prestige = "PRESTIGE7"
    elif(catNar == 9):
        prestige = "GENERAL"
    else:
        red()
        print("Xətalı əmr!") 


def conNar(narSeries):
    global narCounter
    global narNumber
    num = [
    narSeries[0],                                            # Split part1                                  
    narSeries[1],narSeries[2],                                  # Split part2 
    narSeries[3],narSeries[4],                                  # Split part3
    narSeries[5],narSeries[6]]                                  # Split part4
    params = {"prefix":prefixNar,
        "a1":num[0].replace("x", ""),
        "a2":num[1].replace("x", ""),
        "a3":num[2].replace("x", ""),
        "a4":num[3].replace("x", ""),
        "a5":num[4].replace("x", ""),
        "a6":num[5].replace("x", ""),
        "a7":num[6].replace("x", ""),
        "prestigeLevel":prestige,
        "size":sizeNar }
    r = requests.get(url["Nar"],params=params,headers=setHeader(1))
    if(len(r.text) > 7):
        narData = json.loads(r.text)
    elif(r.status_code != 200):
        red()
        print("Key xətalıdır")
        exit(1)
    else:
        light_red()
        print("Nömrə tapılmadı!")
        exit(1)
    
    for nar in narData:
        narTwo = (nar["msisdn"])
        narNumber = narNumber+str(narTwo[3:])+"\n"
        narCounter=narCounter+1
    return narNumber

def getNarCointer():
    return narCounter


def logo():
    yellow()
    logo_index = random.randint(0, 12)
    logo = list()
    logo = [
    """
      @@@@               @@@@                                             
      @@   @@@@@@@@@@@@@   @@                                             
      @@ @@@@@@@@@@@@@@@@@ @@                                             
       @@@  @ ,@@@@@( @* @@@                                              
     &@@@@@@ @@@@@@@@@,#@@@@@%                                            
     &@@@@.....@@ @@....,@@@@&                                            
      #@@@@@@@@@@@@@@@@@@@%       @@@@@                                  
          /@@@@@@@@@@@@         @@@                                      
          @@@@@@@@@@@@@@       (@@                                       
          @@@@@@@@@@@@@@@       @@(                                      
          @@@@@@@@@@@@@@@@@@     .@@@                                    
          @@@@@@@@@@@@@@@@@@@@       @@@@                                
           @@@@@@@@ @@@@ #@@@@@         @@@                              
            @@@@@@ @@@@ .@@@@@@          @@                              
             @@@ @.@@@@.@@@@@@@         @@@                              
             @@@@ @@@@ @@@@@@@ @@@@@@@@@@                             
    """
    ,
    """
╭━━━╮┈┈╱╲┈┈┈╱╲
┃╭━━╯┈┈▏▔▔▔▔▔▕
┃╰━━━━━▏╭▆┊╭▆▕
╰┫╯╯╯╯╯▏╰╯▼╰╯▕
┈┃╯╯╯╯╯▏╰━┻━╯▕
┈╰┓┏┳━┓┏┳┳━━━╯
┈┈┃┃┃┈┃┃┃┃┈┈┈┈
┈┈┗┻┛┈┗┛┗┛┈┈┈┈
    """
    ,
    """
    
_§§§§§___§§§§§§§__§§§§§§
§§§§§§§§§_______§§§§§§c§§
§§§§§§_____________§§§§d§
§§§§_________________§§§§
§§§___________________§§§
_§§___________________§§
_§_____________________§
_§__§§§___________§§§__§
§__§___§_________§___§__§
§_§_§§__§_______§__§§_§_§
§_§_§§§_§_______§_§§§_§_§
§_§_§§§_§_§§§§§_§_§§§_§_§
§__§___§__§§§§§__§___§__§
_§__§§§____§§§____§§§__§
_§_______§__§__§_______§
__§_______§§_§§_______§
___§§_______________§§
_____§§___________§§
____§§§§§§§§§§§§§§§§§
___§§_______________§§
__§§______§§§§§______§§
_§§§______§___§______§§§
§§§§§_____§___§_____§§§§§
§§§§§____§_____§____§§§§§
§§§§§____§_____§____§§§§§
_§§§§§§§§_______§§§§§§§§
__§§§§§§§_______§§§§§§§
__§§___§§_______§§___§§
__§§___§§_______§§___§§
__§§___§§_§§§§§_§§___§§
__§§§§§§§§_____§§§§§§§§
___§§§§§_________§§§§§
    """
    ,
    """
         _nnnn_
        dGGGGMMb
       @p~qp~~qMb
       M|@||@) M|
       @,----.JM|
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    `.       | `' \Zq
_)      \.___.,|     .'
\____   )MMMMMP|   .'
     `-'       `--' hjm

    """
    ,

    """
┈┈╭━╱▔▔▔▔╲━╮┈┈┈
┈┈╰╱╭▅╮╭▅╮╲╯┈┈┈
╳┈┈▏╰┈▅▅┈╯▕┈┈┈┈
┈┈┈╲┈╰━━╯┈╱┈┈╳┈
┈┈┈╱╱▔╲╱▔╲╲┈┈┈┈
┈╭━╮▔▏┊┊▕▔╭━╮┈╳
┈┃┊┣▔╲┊┊╱▔┫┊┃┈┈
┈╰━━━━╲╱━━━━╯┈╳
    """
    ,
    """
┈┈╱╲┈┈┈╱╲┈┈╭━╮┈
┈╱╱╲╲__╱╱╲╲┈╰╮┃┈
┈▏┏┳╮┈╭┳┓▕┈┈┃┃┈
┈▏╰┻┛▼┗┻╯▕┈┈┃┃┈
┈╲┈┈╰┻╯┈┈╱▔▔┈┃┈
┈┈╰━┳━━━╯┈┈┈┈┃┈
┈┈┈┈┃┏┓┣━━┳┳┓┃┈
┈┈┈┈┗┛┗┛┈┈┗┛┗┛┈
    """
    ,
    """
___$$$_____________$$$
__$___$___________$___$
_$_____$_________$_____$
_$_$$___$$$$$$$$$___$$_$
_$_$$$___$______$__$$$_$
_$_$__$__$______$_$__$_$
_$_$__$$$________$$__$_$
_$_$$$_____________$$$_$
_$_$_________________$_$
__$___________________$
__$___________________$
_$_____________________$
_$____$$_________$$____$
$____$_$$_______$_$$____$
$____$o_$_______$o_$____$
$_____$$___$$$___$$_____$
_$_______$__$__$_______$
__$_______$$_$$_______$
___$_________________$
____$$_____________$$
______$$$$$$$$$$$$$
________$_______$
_______$_________$
___$$$_$_________$_$$$
__$___$$___$$$___$$___$
__$____$___$_$___$____$
__$____$$$$$_$$$$$____$
__$____$___$_$___$____$
___$$$$$$$$___$$$$$$$$
    """,

    """
________$$$$$$$$$
______$$_________$$
_____$_____________$
____$_______________$
___$$_______________$$
__$$_________________$$
__$_$_$$_________$$_$_$
_$__$$$$$_______$$$$$__$
_$__$$o$$_______$o$$$__$
_$__$_$$_________$$_$__$
_$__$_______________$__$
$___$_____$$$$$_____$___$
$___$_____$$$$$_____$___$
$___$$_____$$$_____$$___$
_$__$$______$______$$__$
_$__$_$__$__$__$__$_$__$
__$_$_$___$$_$$___$_$_$
___$$__$_________$__$$
______$_$$_____$$_$
______$___$$$$$___$
______$___________$
_____$_____________$
_____$_____________$
____$$____$___$____$$
___$_$____$___$____$_$
___$_$____$___$____$_$
___$__$___$___$___$__$
___$__$___$___$___$__$
__$___$___$___$___$___$
__$___$____$_$____$___$
___$$$$____$$$____$$$$
_______$$$$___$$$$
    """
    ,
    """
┈╭━━━━━━━━━━━╮┈ 
╭╯┈╭━━╮┈╭━━╮┈╰╮ 
┃┈┃┃╭╮┃┈┃╭╮┃┃┈┃ 
┃┈┃┻┻┻┛┈┗┻┻┻┃┈┃ 
┃┈┃╭╮┈◢▇◣┈╭╮┃┈┃ 
╰┳╯┃╰━━┳┳┳╯┃╰┳╯ 
┈┃┈╰━━━┫┃┣━╯┈┃┈ 
┈┃┈┈┈┈┈╰━╯┈┈┈┃┈


    """,
    """
▕▔▔╲╱▔▔▔╲╱▔▔▏
┈╲＿╱╰╮┈╭╯╲＿╱
┈┈┈▏▉╮┈╭▉▕
┈┈╱╲╰╰┊╯╯╱╲
┈╱╰▕╰╰┳╯╯▏╯╲
▕╰╰╰╲╰┻╯╱╯╯╯▏
▕╰╰╰╰▔▔▔╯╯╯╯▏
▕╰╰╰╰╰╮╭╯╯╯╯▏
┈╲╭╮┈╰╮╭╯╭╮╱
┈┈┫┣╭━━━╮┫┃
┈┈┃┃┃┈┈┈┃┃┃
┈┈┗┛┛┈┈┈┗┗┛

    """,
    """
________$$$$_______________
_______$$__$_______________
_______$___$$______________
_______$___$$______________
_______$$___$$_____________
________$____$$____________
________$$____$$$__________
_________$$_____$$_________
_________$$______$$________
__________$_______$$_______
____$$$$$$$________$$______
__$$$_______________$$$$$$
_$$____$$$$____________$$$
_$___$$$__$$$____________$$
_$$________$$$____________$
__$$____$$$$$$____________$
__$$$$$$$____$$___________$
__$$_______$$$$___________$
___$$$$$$$$$__$$_________$$
____$________$$$$_____$$$$
____$$____$$$$$$____$$$$$$
_____$$$$$$____$$__$$
_______$_____$$$_$$$
________$$$$$$$$$$

    """,

    """
+88_________________+880
_+880_______________++80
_++88______________+880
_++88_____________++88
__+880___________++88
__+888_________++880
__++880_______++880
__++888_____+++880
__++8888__+++8880++88
__+++8888+++8880++8888
___++888++8888+++8888+80
___++88++8888++888888++88
___++++++888888fx888888888
____++++++8888888888888888
____++++++++00088888888888
_____+++++++00008f8888888
______+++++++00088888888
_______+++++++0888f8888

    """,

    """
     .-----.
   .' -   - '.
  /  .-. .-.  \
  |  | | | |  |
   \ \o/ \o/ /
  _/    ^    \_
 | \  '---'  / |
 / /`--. .--`\ \
/ /'---` `---'\ \
'.__.       .__.'
    `|     |`
     |     \
     \      '--.
      '.        `\
        `'---.   |
   jgs     ,__) /
            `..'
    """
    ]

    return logo[logo_index]
