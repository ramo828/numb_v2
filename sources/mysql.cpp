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
#include <cppconn/prepared_statement.h>


using namespace std;
using namespace sql::mysql;

string login;
string pass;
sql::Driver *driver;

// Connection sql
sql::Connection *connDB::conn() {
	sql::Connection *con;
	try {
  		driver = get_driver_instance();
  		con = driver->connect(server, dbName, dbPass);
  		con->setSchema(dbUserName);
 	} catch (sql::SQLException &e) {
		except(e);
 	}

 	return con;
	delete con;

}

bool connDB::checkUserStatus(string user, string pass) {
    sql::PreparedStatement  *prep_stmt;
	try {
	sql::Connection *con1 = connDB::conn();
	prep_stmt = con1 -> prepareStatement("SELECT * from accounts WHERE user=? and pass=? and status=1");
	prep_stmt -> setString(1, user);
	prep_stmt -> setString(2, pass);
	sql::ResultSet *rs = prep_stmt->executeQuery();
	if(rs->next())
		return true;
	else
		return false;

	delete prep_stmt;
	delete con1;
	delete rs;
	 } catch (sql::SQLException &e) {
		except(e);
 	}
		return false;
    return true;
}

sql::ResultSet *connDB::resQuery(string query) {
	sql::Connection *con1 = connDB::conn();
 	sql::Statement *stmt = con1->createStatement();
	sql::ResultSet *res = stmt->executeQuery(query);
	return res;
	delete res;
	delete con1;
	delete stmt;
}
// Sql sorgu gonderme
void connDB::query(string query) {
	sql::Connection *con1 = connDB::conn();
	sql::Statement *stmt = con1->createStatement();
	stmt -> execute(query);
	delete con1;
	delete stmt;
}
// User ve parola gore sistemde qarsilasdirma
bool connDB::checkUserAndPass(string user, string pass) {
	sql::PreparedStatement  *prep_stmt;
	try {
	sql::Connection *con1 = connDB::conn();
	prep_stmt = con1 -> prepareStatement("SELECT * from accounts WHERE user=? and pass=?");
	prep_stmt -> setString(1, user);
	prep_stmt -> setString(2, pass);
	sql::ResultSet *rs = prep_stmt->executeQuery();
	if(rs->next())
		return true;
	else
		return false;

	delete prep_stmt;
	delete con1;
	delete rs;
	 } catch (sql::SQLException &e) {
		except(e);
 	}
		return false;
}

// Reset Table and id
void connDB::resetTable() {
	connDB::query("truncate table accounts");
}
// ID gore istifadeci silinir
void connDB::delUser(int id) {
	sql::PreparedStatement  *prep_stmt;
	sql::Connection *con1 = connDB::conn();
	prep_stmt = con1 -> prepareStatement("DELETE FROM `accounts` WHERE `accounts`.`id` = ?");
	prep_stmt -> setInt(1, id);
	prep_stmt -> execute();
}


// Data alma
string connDB::getData(string qdata) {
	sql::ResultSet *res1 = connDB::resQuery("SELECT * FROM `accounts`");
	string datas;
	while (res1->next()) {
    		datas = res1->getString(qdata);
	}
	return datas;
	delete res1;
}
// Xeta ayirma
void connDB::except(sql::SQLException &e) {
	cout << "# ERR: SQLException in " << __FILE__;
	cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
	cout << "# ERR: " << e.what();
	cout << " (MySQL error code: " << e.getErrorCode();
	cout << ", SQLState: " << e.getSQLState() << " )" << endl;

}

