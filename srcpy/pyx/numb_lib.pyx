import os.path                 # Lib
import os
import time as tm
import requests
from bs4 import BeautifulSoup as soup
import subprocess
import json

#######################################################################################
#######################################VARIABLE########################################
bKeyDefault ="Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJNQUlOIiwiZXhwIjoxNjQ5MzM0NzAyfQ.N2Jt28lAVMLhw4mnGJwM0QbHsEaW8c3raG-xzjufnh05uGPrJuNZvfsy8-A-M-suzpCYV-XYgBrthwui7NAadw"
dirs = os.getcwd()+"/.config/"                           # Oldugun qovluq
ddir = "/sdcard/work/"
number = "xxxxx"               # Null data protected
err = 0;                       # Xeta
path = "default.dir"           # Export edilecek qovluq
fileName = "/Ramo_SOFT_all_Contacts.vcf"   # Export edilecek kintakt fayli
prefixSel = ["55","99"];       # Prefix secimi
prefixValue = 0
categoryKey = "sadə"
begin = 0                      # Baslangic 
end = 0
reverseValue = 0
binPath = ""
dataVcard = [
 "BEGIN:VCARD\n"
,"N:","FN:"
,"TEL;TYPE=WORK,MSG:"
,"EMAIL;TYPE=INTERNET:\n"
,"END:VCARD\n"]
url = "https://public-api.azerconnect.az/msbkcposappreservation/api/freemsisdn-nomre/search";
#------------------055----------------------------
category = dict()
categoryKey = "sadə";          # Sade Nomreleri
category["sadə"] = "1429263300716842758";               # Sade key
category["xüsusi1"] = "1579692503636523114";            # Xususi1 key
category["xüsusi2"] = "1579692547752973099";            # Xususi2 key
categoryKey055 = "sadə"        # 099 sade nomreler
#------------------099----------------------------
category["sadə099"] = "1574940031138475856";            # Sade key
category["bürünc"] = "1582551518546595643";             # Burunc key
category["gümüş"] = "1582551485948558941";              # Gumus key
category["qızıl"] = "1582551461421619154";              # Qizil key
category["platin"] = "1582551437850968791";             # Platin key
categoryKey099 = "bürünc"                               # Buruc nomreler
page = 0;                                               # Sehife 0
max = 1000*10;                                          # Maksimum ne qeder gosterilsin
prefixGlo = ["+99450","+99451","+99410","+99455","+99499","+99470","+99477","+99460"]
azBegin = 0
azEnd = int(len(prefixGlo))
azIndex = 3                                             # 010 nomre
configData = ""
binPath = "" 
#######################################################################################
######################################ORTAQ############################################

def conv_numeric(counter):
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

    return clone;


def quest1():
    #-------------------------------------------------
    try:
        print(""""
        -----------------------------------------------
        Nömrə kombinasiyasını daxil edin və boş xanalari
        x ilə tamamlayın.
        Məs: 83027xx
        -----------------------------------------------
        """)
        global number
        global err
        while (len(number) <7):
            if(err > 0):
                print("""
                ------------------------------
                Nömrə düzgün qeyd edilməyib
                ------------------------------
                """)    
            err=err+1;
            number = str(input(">> "))                                      # Sual 1   
        return number 
    except (EOFError, KeyboardInterrupt):
        pass
def fileControl():
    author_logo = logo()
    try:
        w = open(readConfig(path)+fileName,"w")
    except FileNotFoundError:
        print("Göstərilən adres mövcud deyil\n"+readConfig(path)+"\n")
        exit(1)
    finally:
        print(author_logo)
    return w

def getFP(index):
    if(index == 0):
        return path                                                             # 0 daxil edilende qovlugu
    elif(index == 1):                                                           # 1 daxil edilende fayl adini qaytar
        return fileName
    else:
        return "Error"

def banEnd(count,end):
    print("\n\tKontakt Hazırlanır")
    tm.sleep(1)
    print("\n\tKontaktlar Hazırdır")
    print("""
    \n
    ------------------------------------------
    Kontaktların sayı: """+ str(count)+"""
    ------------------------------------------
    """)
    print("""
    Tapılan nomrə sayı: """+ str(count/end)+"""
    -----------------------------------------
    """)
    outputInfo()
def banBegin():
    tm.sleep(1)
    print("\n\tMəlumatlar serverdən alınır")
    tm.sleep(1)
    print("\n\tMəlumatlar işlənir")
    tm.sleep(1)

def vcardWrite(w,contactName,prefix,pre,dataFour,count1):
    w.write(
    dataVcard[0]
	+dataVcard[1]+contactName+conv_numeric(count1)+"\n"	
	+dataVcard[2]+contactName+conv_numeric(count1)+"\n"
	+dataVcard[3]+prefix[pre]+dataFour[2:9]+"\n"
	+dataVcard[4]
	+dataVcard[5])

#####################################################################################
#####################################################################################
###############################BAKCELL###############################################



def AI_Select():
    global categoryKey
    global prefixValue
    prefixValue = int(input("Prefix: (0 - 55; 1 - 99: "));              # Sual 2 055 yoxsa 099?
    if(prefixSel[prefixValue] == "55"):
        print("""-------------------------------------\n
        \tKategoriya seç\n
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
            print("""
            ----------------
            Xətalı seçim
            ----------------
            """)
    elif(prefixSel[prefixValue] == "99"):
        print("""
        -------------------------------------\n
        \tKategoriya seç\n
        0 - Sadə\n
        1 - Bürünc\n
        2 - Gümüş\n
        3 - Qızıl\n
        4 - Platin
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
            print("""
            ------------------
            Xətalı seçim
            -------------------
            """)
    else:
            print("""
            -------------------
            Xətalı seçim
            -------------------
            """)
    
    
def getPrCt(index):
    if(index == 0):
        return prefixValue
    elif(index == 1):
        return categoryKey


def numLimit():
    global reverseValue
    global end
    global begin
    reverseValue = 0;                                                                 # 055 nomrələr seçildikdə kontakta 099
    if(prefixValue == 0):                                                             # nömrələri əlavə et
        reverseValue = 1                                                              #
    else:                                                                             #
        reverseValue = 0 

    intervalMsg = """\n
    \t ----Operator aralığını daxil edin----
    \t 1) Azərcell  (050)
    \t 2) Azərcell  (051)
    \t 3) Azərcell  (010)
    \t 4) Bakcell   (0{})
    \t 5) NarMobile (070)
    \t 6) NarMobile (077)
    \t 7) Naxtel    (060)
    \t 0) Hamısı
    \t (Nümunə: 1:3) (Azərcell-dən Bakcell-ə qədər)
    """.format(prefixSel[reverseValue])
    print(intervalMsg);
    rawData = str(input(">> "))
    noRawData = ""
    if(not rawData.isdigit()):
        noRawData = rawData.split(":")
        begin = int(noRawData[0])-1
        end = int(noRawData[1])
    elif(int(rawData) == 0):
        begin = 0
        end = 7
    else:
        print("Xəta baş verdi")


def readConfig(conf):
    if(os.path.exists(dirs+conf)):
        config = open(dirs+conf,"r")
        configData = config.read()
        return configData
    else:
        configData = ddir
        return configData

def outputInfo():
    global configData
    print("OUTPUT: "+configData)


def keyReadFile():
    global bKeyDefault
    
    os.system("clear")
    #print(binPath)

    if(os.path.exists(dirs+"bKey.data")):
        bFile = open(dirs+"bKey.data","r")
        tm.sleep(1)
        os.system("clear")
        print("#####External key selected#####")
        bKeyDefault = bFile.read()
        return bKeyDefault
    else:
        tm.sleep(1);
        os.system("clear");
        print("#####Default key selected#####")
        return str(bKeyDefault)


bKey = keyReadFile()
headers = {'content-type': 'application/json',          # Content type json
'Accept':'application/json, text/plain, */*',           # Accept type json
'Accept-Encoding':'gzip, deflate, br',                  # Encoding gzip compressed data
'Accept-Language':'tr-TR,tr;q=0.9,az-TR;q=0.8,az;q=0.7,en-US;q=0.6,en;q=0.5',
'Authorization':bKey,
'Connection':'keep-alive'}


def getIndex(index):
    if(index == 0):
        return begin
    elif(index == 1):
        return end
    elif(index == 2):
        return reverseValue
    else:
        return "ERROR"


prefixVar = ["+99450","+99451","+99410","+994"+prefixSel[getIndex(2)],"+99470","+99477","+99460"]     # dogru

def prefixDef():
    return prefixVar

def conBakcell(page):
    r = requests.get(url, params={"prefix":prefixSel[prefixValue],
    "msisdn":number,                                        # Nomre datasi
    "categoryId":category[categoryKey],                     # Kategorya
    "showReserved":"true",                                  # Sifaris verilenler
    "size":"2000",                                          # Maksimum nomre sayi
    "page":page},                                           # Maksimum sehife sayi
    headers=headers)                                        # Header
    return r


def getConMaxData(catValKey):
    r = requests.get(url, params={"prefix":prefixSel[prefixValue],
    "msisdn":number,                                        # Nomre datasi
    "categoryId":category[catValKey],                       # Kategorya
    "showReserved":"true",                                  # Sifaris verilenler
    "size":"2000",                                          # Maksimum nomre sayi
    "page":"0"},                                           # Maksimum sehife sayi
    headers=headers)                                        # Header
    return r

######################################################################################
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


######################################################################################
######################################################################################
######################################################################################
##################################AZERCELL############################################

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
gozleme = 1/50;                                        # Data alma zamani
sum_d = ""

def sum_data():
   return sum_d

def extractData(number,page):
   url = "https://azercellim.com/az/search/"
   num = [number[0],                                     # Split part1                                  
   number[1],number[2],                                  # Split part2 
   number[3],number[4],                                  # Split part3
   number[5],number[6]]                                  # Split part4
   prefix = ["90","50","51","10"]                        # Prefix var
   p = {
   "num1":num[0],                                        # Number Splitter 1
   "num2":num[1],                                        # Number Splitter 2
   "num3":num[2],                                        # Number Splitter 3
   "num4":num[3],                                        # Number Splitter 4
   "num5":num[4],                                        # Number Splitter 5
   "num6":num[5],                                        # Number Splitter 6
   "num7":num[6],                                        # Number Splitter 7
   "prefix":prefix[azIndex],                             # Prefix
   "send_search":"1"}                                    # Page
   
   r = requests.post(url+str(page),data=p,verify=ssl,headers=h)    # Request Send
   source = soup(r.content,"lxml")
   find = source.findAll("div", attrs={"class":"phonenumber"})
   return find

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
            print("Melumat yoxdur")
            exit(1) # deyisdim
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
         print("Biraz gözləyin"+dot)
         print(loading_bar)
         sum_d=sum_d+str(sp)
      dot_count = dot_count +1
      count_num=count_num+1

def soupData(find):
   rawData = ""
   for findData in find:
      rawData=rawData +"\n"+str(findData.text).replace("\n","")
   return rawData

def setAzEnd(_azEnd):
    global azEnd
    azEnd = _azEnd

def setAzBegin(_azBegin):
    global azBegin
    azEnd = _azBegin


def getAzEnd():
    return azEnd

def getAzBegin():
    return azBegin


def getAzPrefix():
    return prefixGlo



def logo():
    logo_author= """
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
    return logo_author
