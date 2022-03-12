import pyautogui as pg
import time as t
#sudo apt-get install xclip
#sudo apt-get install xsel
#sudo apt-get install wl-clipboard
import pyperclip as pc
import sys

contactName = "Metros"
status = 0
startTime = 10
begin = 1                                     # Baslama noqtesi (min=1)
count = 0                                     # saygac
flag =  True                                  # Bayraq
limit = 100                                   # Limit
msgSpeed = 0.0                                # Atilacaq mesajin sureti

def runRobo(x):
    print("robo calisdi "+str(x));

try:
    if(sys.argv[1] == "default"):
        status = 1
except IndexError:
    status = 0

if(status == 0):
    contactName = str(input("Kontakt adı: "))
    startTime = int(input("Başlama vaxtı (san): "))
    begin = int(input("Başlanğıc addım: "))
    limit = int(input("Bitiş addımı: "))

t.sleep(startTime)                            # Start 10 san
try:
    msg = open('message/0','r')
except FileNotFoundError:
    print("\n Mesaj fayli tapilmadi")
data = msg.read()
pc.copy(data)
count=count+begin                             # Saygaca baslangic deyeri elave et
while flag:
    pg.hotkey('ctrl','alt','n')               # Search contacts
    pg.write(" "+contactName, interval=0.50)      # Contact name
    print(count)                              # saygaci goster 
    if(count < 10):
        msgSpeed = 1.0
    elif(count >=10 and count <= 50):
        msgSpeed = 0.75
    elif(count >= 51 and count <= 100):
        msgSpeed = 0.50
    else:
        msgSpeed = 0.20

    pg.press('down',presses=count,interval=msgSpeed)
    t.sleep(0.300)
    pg.press('enter')
    t.sleep(0.700)
    pg.hotkey('ctrl','v')
    t.sleep(0.700)
    pg.press('enter')
    t.sleep(0.200)
    if(limit == count):
        print("Limitə çatdı")
        flag = False
    count=count+1;
    
