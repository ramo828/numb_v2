/* Copyright 2008, 2010, Oracle and/or its affiliates. All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2 of the License.

There are special exceptions to the terms and conditions of the GPL
as it is applied to this software. View the full text of the
exception in file EXCEPTIONS-CONNECTOR-C++ in the directory of this
software distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
*/
#include <stdlib.h>
#include <iostream>
#include "mysql_connection.h"
#include "../include/conn.hpp"
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;
using namespace sql::mysql;



string login;
string pass;
sql::Driver *driver;
sql::Connection *con;
sql::Statement *stmt;
sql::ResultSet *res;



int conn(void)
{

try {
 
  /* Create a connection */
  driver = get_driver_instance();
  con = driver->connect("tcp://remotemysql.com:3306", "3KndKumGco", "nx9GiSsadD");
  /* Connect to the MySQL test database */
  con->setSchema("3KndKumGco");

  stmt = con->createStatement();
  res = stmt->executeQuery("SELECT * FROM `accounts`");
  while (res->next()) {
    cout << "\tIstifadeci: ";
    /* Access column data by alias or column name */
    login = res->getString("user");  // user
    cout << "\tParol: ";
    if(login == "rauf94")
	    cout << endl <<"dogru login" << endl;
    cout << res->getString("pass") << endl;  // pass
  }
  delete res;
  delete stmt;
  delete con;

} catch (sql::SQLException &e) {
  cout << "# ERR: SQLException in " << __FILE__;
  cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
  cout << "# ERR: " << e.what();
  cout << " (MySQL error code: " << e.getErrorCode();
  cout << ", SQLState: " << e.getSQLState() << " )" << endl;
}

cout << endl;

return EXIT_SUCCESS;
}
