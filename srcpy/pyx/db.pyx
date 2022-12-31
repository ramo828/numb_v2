import mysql.connector
from mysql.connector import errorcode
import sqlite3
import datetime
import numb_lib as nl
import hashlib as hl
import subprocess as sp


################################SQLLite####################################
account = "CREATE TABLE if NOT EXISTS account (user TEXT, pass TEXT)"
server = "CREATE TABLE if NOT EXISTS sqlServer (host TEXT,user TEXT, pass TEXT, database TEXT)"
settings = "CREATE TABLE if NOT EXISTS settings (keyBakcell TEXT, keyNar TEXT, contactName TEXT, homeDir TEXT, autoKey INT,serverNumber INT)"
history = "CREATE TABLE if NOT EXISTS number (Date TEXT ,operator TEXT, prefix TEXT, series TEXT, category TEXT)"
log = "CREATE TABLE if NOT EXISTS log (Date TEXT ,line TEXT, error TEXT, errno INT)"

db_file = ".config/numb_data.db"
command = [
account,
settings,
history,
log,
server
]


con = sqlite3.connect(db_file)
cursor = con.cursor()

def createTable():                                                                             # Tablo qur
    for i in range(len(command)):
        cursor.execute(command[i])
    con.commit()

def addAccount(user,password):                                                                 # Account elave et
    addValue = "INSERT INTO account VALUES('{0}','{1}')".format(user,password)
    cursor.execute(addValue)
    con.commit()

def addServer(host,user,password,db):                                                                 # Account elave et
    addValue = "INSERT INTO sqlServer VALUES('{0}','{1}','{2}','{3}')".format(host,user,password,db)
    cursor.execute(addValue)
    con.commit()

def updateServer(host,user,password,db):                                                                 # Account elave et
    addValue = "UPDATE sqlServer SET host = '{0}',user= '{1}',pass= '{2}',database= '{3}'".format(host,user,password,db)
    cursor.execute(addValue)
    con.commit()

def addSettings(keyBakcell,keyNar,contactName,homeDir, autoStatus, serverNumber):                                        # Ayarlar
    addValue = "INSERT INTO settings VALUES('{0}','{1}', '{2}', '{3}', '{4}','{5}')".format(keyBakcell,keyNar,contactName,homeDir,autoStatus,serverNumber)
    cursor.execute(addValue)
    con.commit()

def getServerData(idx):
    sql = "SELECT * FROM sqlServer"
    cursor.execute(sql)
    data = cursor.fetchall()
    return data[0][idx]

def updateKeyLocal(key,op):                                                                         # Key Bakcell/Nar
    if(op == 0):
        keyValue = "UPDATE settings SET keyBakcell = '{0}'".format(key)
    elif(op == 1):
        keyValue = "UPDATE settings SET keyNar = '{0}'".format(key)
    else:
        raise TabError("Operator tapılmadı!")
    cursor.execute(keyValue)
    con.commit()

def updateDir(dir):                                                                            # Esas qovluq
    keyValue = "UPDATE settings SET homeDir = '{0}'".format(dir)
    cursor.execute(keyValue)
    con.commit()

def autoKey():                                                  # AvtoKey
    Value = "SELECT autoKey FROM settings "
    cursor.execute(Value)
    data = cursor.fetchall()
    return data[0][0]

def updateName(name):                                                                          # kontakt adini deyisdir
    keyValue = "UPDATE settings SET contactName = '{0}'".format(name)                  
    cursor.execute(keyValue)
    con.commit()

def getUserData(index):
    try:
        if(index == 0):
            sql = "SELECT user FROM account"
        elif(index == 1):
            sql = "SELECT pass FROM account"
        else:
            raise TypeError("Index tapılmadı")                                  
        cursor.execute(sql)
        data = cursor.fetchall()
        return data[0][0]
    except IndexError:
       pass
    

def getKey(op):                                                                                # Keyi cagir Bakcell/Nar
    if(op == 0):
        sql = "SELECT keyBakcell FROM settings"
    elif(op == 1):
        sql = "SELECT keyNar FROM settings"
    else:
        raise TypeError("Operator tapılmadı")
    cursor.execute(sql)
    data = cursor.fetchall()
    return data[0][0]

def getName():                                                                               
    sql = "SELECT contactName FROM settings"
    cursor.execute(sql)
    data = cursor.fetchall()
    return data[0][0]

def getServerNumber():                                                                             
    sql = "SELECT serverNumber FROM settings"
    cursor.execute(sql)
    data = cursor.fetchall()
    return data[0][0]

def getHomeDir():                                                                               
    sql = "SELECT homeDir FROM settings"
    cursor.execute(sql)
    data = cursor.fetchall()
    return data[0][0]


def insertNumber(operator, prefix, series, category):
    date = datetime.datetime.now()
    operatorS = ""
    if(operator == 1):
        operatorS = "Bakcell"
    elif(operator == 2):
        operatorS = "Azercell"
    elif(operator == 3):
        operatorS = "Nar"
    else:
        raise TypeError("Operator xətalı seçilib!")
    addValue = "INSERT INTO number VALUES('{0}','{1}', '{2}', '{3}','{4}')".format(date,operatorS,prefix,series, category)
    cursor.execute(addValue)
    con.commit()

def addLog(line, error, errorNo):
    date = datetime.datetime.now()
    addValue = "INSERT INTO log VALUES('{0}','{1}', '{2}', '{3}')".format(date,line,error,errorNo)
    cursor.execute(addValue)
    con.commit()

def closeDB():
    con.close()

###################################EndSQLLite#########################################################
def conn():
  try:
    host = getServerData(0)
    user = getServerData(1)
    password = getServerData(2)
    database = getServerData(3)

    cnx = mysql.connector.connect(host=host,
                                user=user,
                                password=password,
                                database=database)
                                
  except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        nl.red()
        print("İstifadəçi adında və ya şifrədə bir problem var")
        exit(1)
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        nl.red()
        print("Verilənlər bazası yoxdur")
        exit(1)
    else:
      print(err)
      exit(1)
  else:
    return cnx

def addSeries(series):
    if(len(series) >5):
        add = "INSERT INTO `numbers` (`id`, `series`) VALUES (NULL, '{series}')".format(series=series)
        connection = conn()
        cursor = connection.cursor()
        cursor.execute(add)
        connection.commit()
        cursor.close()
    else:
            nl.red()
            print("Xəta baş verdi. [addSeries function]")
    #except (TypeError, KeyboardInterrupt):
    #    pass


def reg(user, password):
    agent = sp.check_output(["uname","-a"])
    hash = hl.sha256(agent).hexdigest()
    if(not len(user) < 5 and not len(password) < 8):
        add = "INSERT INTO `accounts` (`user`, `pass`, `status`, `id`,`level`,`userHash`,`userAgent`,`saygac`) VALUES ('{user}', '{password}', '0', NULL,0,'{hash}','{agent}','0');".format(user=user,password=password,hash=hash,agent=str(agent,encoding='UTF-8'))
        connection = conn()
        cursor = connection.cursor()
        cursor.execute(add)
        connection.commit()
        cursor.close()
    else:
        nl.red()
        print("Xəta baş verdi. Login minimum [5] və parol minimum [8] simvoldan ibarət olmalıdır!")

def checkUserAndPassword(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is None:
      return False
    else:
      return True

    
def getHash(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[5]
    else:
        return 0

   
def getID(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[3]
    else:
        return 0
        
 
def getCounter(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[7]
    else:
        return 0

def alreadyUser(login):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' """.format(login=login)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is None:
      return False
    else:
      return True

def checkUserLevel(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[4]
    else:
        return 0
    
def checkUserStatus(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE BINARY `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[2]
    else:
        return 0


def accoundBlocked(id):
    sql = "UPDATE `accounts` SET `status` = '0' WHERE `accounts`.`id` = {0};".format(id)
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()


def counterAdd(id,count):
    sql = "UPDATE `accounts` SET `saygac` = '{1}' WHERE `accounts`.`id` = {0};".format(id, count)
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()

def updateKey(op):
    if(op == 0):
        sql = "SELECT keyBakcell FROM `system`"
    elif(op == 1):
        sql = "SELECT keyNar FROM `system`"
    else:
        nl.red()
        print('Xətalı operator')
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(sql)
    record = cursor.fetchone()
    return record[0]

def updateGlobalKey(op, key):
    if(op == 0):
        sql = "UPDATE `system` SET `keyBakcell` = 'Bearer {0}' WHERE `system`.`id` ".format(key)
    elif(op == 1):
        sql = "UPDATE `system` SET `keyNar` = 'Bearer {0}' WHERE `system`.`id` ".format(key)
    else:
        nl.red()
        print('Xətalı operator')
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()


def updateRealKey(op, key):
    if(op == 0):
        sql = "UPDATE `system` SET `keyBakcell` = 'Bearer {0}' WHERE `system`.`id` ".format(key)
    elif(op == 1):
        sql = "UPDATE `system` SET `keyNar` = 'Bearer {0}' WHERE `system`.`id` ".format(key)
    else:
        nl.red()
        print('Xətalı operator')
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()

