#ifndef conn_hpp
#define conn_hpp
#include <iostream>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;

class connDB {

	private:

	public:
		void resetTable();
		bool checkUserAndPass(string user, string pass);
		bool checkUserStatus(string user, string pass);
		int showID(string user);
		string showUser(int id);
		void delUser(int id);
		sql::Connection *conn();
		void except(sql::SQLException &e);
		sql::ResultSet *resQuery(string query);
		void query(string query);
		string getData(string qdata);
		string server = "tcp://remotemysql.com:3306";
		string dbName = "3KndKumGco";
		string dbUserName = "3KndKumGco";
		string dbPass = "nx9GiSsadD";

};




#endif
