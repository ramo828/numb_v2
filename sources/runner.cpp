#include <iostream>
#include <sqlite3.h>
#include "../include/mylib.hpp"

using namespace std;


static int callback(void* data, int argc, char** argv, char** azColName)
{
	int i;
	fprintf(stderr, "%s", (const char*)data);

	for (i = 0; i < argc; i++) {
		cout << "-------------------------------------\n";
		printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
		cout << "-------------------------------------\n";
	}

	printf("\n");
	return 0;
}

void run::runner() {
	util u;              // Aletler
	userUI ui;           // Istifadeci interfeysi
	ext e;
	if(_gcount > 1) {
		if(u.equals(_garr[1],"-stat","--statistic")){
			ui.runPY(statistic);                                  // Analiz modu
			exit(1);                                              // python calisandan sonra cpp'den cix
		}
		
		else if(u.equals(_garr[1],"-v","--version")){
			u.writeln(__VERSION_APP__);
			exit(1);                                              // python calisdiqdan sonra cpp'den cix
		}
		else if(u.equals(_garr[1],"-global","--globalKey")){
			ui.runPY(e.getBin()+"srcpy/main.py","--updateGlobalKey",u.str(_garr[2]),u.str(_garr[3]));
			u.writeln("Operator: "+u.str(_garr[2]));              // daxil edilen keyi goster
			u.writeln("Key: "+u.str(_garr[3]));                   // daxil edilen keyi goster

			exit(1);                                              // python calisdiqdan sonra cpp'den cix
		}

		else if(u.equals(_garr[1],"-i","--info")){
			DB db;
			cout << "\n\t-----MƏLUMAT-----\n";
			cout << endl <<"Program versiyası: " << __VERSION_APP__ << endl << endl;
			cout << "\tİstifadəki adı və şifrəsi: "; 
			db.readDB("select * from account");
			cout << "\tUserAgent: "<<endl;
			system("uname -a");
			cout <<  endl;
			cout << "\tUserAgentKey: "<< endl;
			system("uname -a | sha256sum");
			cout << endl;
			cout << "\tNumb ayarlar: " ;
			db.readDB("select * from settings");
			cout << "\tServer məlumatları: ";
			db.readDB("select host from sqlServer");

		}

		else if(u.equals(_garr[1],"-k","--key")){
			util u;
			DB db;
			db.updateBakcellKey("Bearer "+u.str(_garr[2]));       // Key yaratma emri
			u.writeln("Key: "+u.str(_garr[2]));                   // daxil edilen keyi goster
		}

		else if(u.equals(_garr[1],"-knar","--keyNar")){
			util u;
			DB db;
			db.updateNarKey("Bearer "+u.str(_garr[2]));           // Key yaratma emri
			u.writeln("Key: "+u.str(_garr[2]));                   // daxil edilen keyi goster
		}
		else if(u.equals(_garr[1],"-ext","--exit")){
			DB db;
			db.clearDb("account");
		}
		else if(u.equals(_garr[1],"-up","--update")){
			string upCommand = "curl https://raw.githubusercontent.com/ramo828/numb_v2/main/build.sh | dash -";
			system(upCommand.c_str());
		}
		else if(u.equals(_garr[1],"-l","--login")){
			DB db;
			ext e;
			string user;
			string pass;
			cout << "\t------Daxil Ol-------" << endl;
			cout << "Login: ";
			cin >> user;
			cout << "Password: ";
			cin >> pass;
			db.login(user,pass);
			system("numb");
		}

		else if(u.equals(_garr[1],"-cn","--contactName")){
			DB db;                                                // DataBase clasini cagir
			db.setName(u.str(_garr[2]));                          // DB'a adi daxil ele
			u.writeln("Kontakt adı: "+u.str(_garr[2]));           // Kontaktin adini goster
		}
		else if(u.equals(_garr[1],"-reg","--register")){
			DB db;
			ext e;
			string user;
			string pass;
			cout << "\t------Qeydiyyat-------" << endl;
			cout << "Login: ";
			cin >> user;
			cout << "Password: ";
			cin >> pass;
			if(user.length() < 5 && pass.length() < 8)
				u.writeln("Login [5] və Parol [8] simvoldan az ola bilməz");
			else {
				db.reg(user,pass);
				ui.runPY(e.bin+"srcpy/main.py --reg "+user+" "+pass);
		}

			exit(1);
		}
		// hesab bloklananda id ile geri getirmek ucun
		else if(u.equals(_garr[1],"-id","--id")){
                          cout << "ID: ";
                          system("uname -a | sha256sum");

                }

		else if(_gcount > 2){
			DB db;
			
			if(u.equals(_garr[1],"-auto","--setAuto")){
				if(u.equals(_garr[2],"true","True"))
					db.setAutoStatus("1");
				else if(u.equals(_garr[2],"false","False"))
					db.setAutoStatus("0");
				else
					cout << "Xəta" << endl;
			}

			else if(u.equals(_garr[1],"-s","--setServer")){
				u.writeln("\t------Server------\n"+u.str(_garr[2]));
				if(u.equals(_garr[2],"0","o")){
					u.writeln("Seçilən server: "+u.str(_garr[2]));
					db.choiseServer("0");
				}
				else if(u.equals(_garr[2],"1","l")){
					u.writeln("Seçilən server: "+u.str(_garr[2]));
					db.choiseServer("1");
				}
				else
					cout << "Xəta" << endl;
			}

		}
		else {

			u.writeln("Taninamayan: "+u.str(_garr[1]));
			exit(1);

		}
	}
	else {
			ui.runPY(numb);
			exit(1);
	}

}

void DB::setAutoStatus(string status){
	string autoStatus = "UPDATE settings SET autoKey = "+status+"";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, autoStatus.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::setName(string name){
	string updateName = "UPDATE settingzs SET contactName = '"+name+"'";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, updateName.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::setHomeDir(string dir){
	string updateDir = "UPDATE settings SET homeDir = '"+dir+"'";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, updateDir.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::clearDb(string db){
	string clear = "DELETE FROM "+db+"";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, clear.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::updateBakcellKey(string key){
	string updateDir = "UPDATE settings SET keyBakcell = '"+key+"'";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, updateDir.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}
void DB::updateNarKey(string key){
	string updateDir = "UPDATE settings SET keyNar = '"+key+"'";
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, updateDir.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::reg(string user, string pass) {
	DB db;
	db.clearDb("account");
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare( database, regSql.c_str(), -1, &st, NULL);
        sqlite3_bind_text(st, 1, user.c_str(), user.length(), SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 2, pass.c_str(), pass.length(), SQLITE_TRANSIENT);
        sqlite3_step( st );

    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
    sqlite3_close(database);
}

void DB::login(string user, string pass) {
	DB db;
	db.clearDb("account");
	db.reg(user,pass);
}

void DB::choiseServer(string ch){
	string test = "select * from accounts";
	string updateName = "UPDATE settings SET serverNumber = "+ch;
	if (sqlite3_open(".config/numb_data.db", &database) == SQLITE_OK) { 
        sqlite3_prepare_v2( database, updateName.c_str(), -1, &st, NULL);
        sqlite3_step( st );
    } else {
	    cout << "DB Open Error: " << sqlite3_errmsg(database) << endl; 
    }
    sqlite3_finalize(st);
	DB::readDB("select * from account");
    sqlite3_close(database);

}

void DB::readDB(string query){
	string data("\n");
	int exit = 0;
	exit = sqlite3_open(".config/numb_data.db", &database);
	string sql(query);
	if (exit) {
		std::cerr << "VB açıla bilmədi! " << sqlite3_errmsg(database) << std::endl;
	}
	else
		{
			cout << endl;
		}
	int rc = sqlite3_exec(database, sql.c_str(), callback, (void*)data.c_str(), NULL);

	if (rc != SQLITE_OK)
		cerr << "Xəta SELECT" << endl;
	else {
		
	}

	sqlite3_close(database);
}

