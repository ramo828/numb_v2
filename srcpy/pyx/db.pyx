import mysql.connector
from mysql.connector import errorcode
import lib
import os

def conn():
  try:
    cnx = mysql.connector.connect(host ="remotemysql.com",
                                user='3KndKumGco',
                                password = "ViwaxpWyiD",
                                database='3KndKumGco')
                                
  except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
      print("İstifadəçi adında və ya şifrədə bir problem var")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
      print("Verilənlər bazası yoxdur")
    else:
      print(err)
  else:
    return cnx

def addSeries(series):
  if(len(series) >5):
    add = "INSERT INTO `numbers` (`id`, `series`) VALUES (NULL, '{series}'); ".format(series=series)
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(add)
    connection.commit()
    cursor.close()
  else:
    print("Xəta baş verdi. [addSeries function]")


def reg(user, password):
  if(not len(user) < 5 and not len(password) < 8):
    add = "INSERT INTO `accounts` (`user`, `pass`, `status`, `id`,`level`) VALUES ('{user}', '{password}', '0', NULL,0);".format(user=user,password=password)
    connection = conn()
    cursor = connection.cursor()
    cursor.execute(add)
    connection.commit()
    cursor.close()
  else:
    print("Xəta baş verdi. Login minimum [5] və parol minimum [8] simvoldan ibarət olmalıdır!")

def checkUserAndPassword(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is None:
      return False
    else:
      return True

def alreadyUser(login):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE `user` LIKE '{login}' """.format(login=login)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is None:
      return False
    else:
      return True

def checkUserLevel():
    notFound = False
    global r
    ddir = os.getcwd()+"/.config/"                           # Oldugun qovluq
    try:
        r = open(ddir+"user.reg","r")
    except FileNotFoundError:
        notFound = True
    alld = r.read()
    login = lib.spl(alld,",",0)
    password = lib.spl(alld,",",1)
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[4]
        print("record 4"+str(record[4]))
    else:
        return 0


def checkUserStatus(login, password):
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `accounts` WHERE `user` LIKE '{login}' AND `pass` LIKE '{password}' """.format(login=login, password=password)
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[2]
    else:
        return 0

def updateKey():
    connection = conn()
    cursor = connection.cursor()
    sql_select_query = """SELECT * FROM `system` WHERE 1"""
    cursor.execute(sql_select_query)
    record = cursor.fetchone()
    if record is not None:
        return record[0]
    else:
        return 0
