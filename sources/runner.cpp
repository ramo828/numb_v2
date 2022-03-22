#include <iostream>
#include "../include/mylib.hpp"

using namespace std;

void run::runner() {
	util u;              // Aletler
	userUI ui;           // Istifadeci interfeysi
	if(_gcount > 1) {
		if(u.equals(_garr[1],"-stat","--statistic")){
			ui.runPY(statistic);
			exit(1);
		}
		else if(u.equals(_garr[1],"-bot","--robot")){
			ui.runPY(robo);
			exit(1);
		}
		else if(u.equals(_garr[1],"-k","--key")){
			userUI ui;
			ui.sysConfig("bKey.data", "Bearer "+u.str(_garr[2]));
			u.writeln("Key: "+u.str(_garr[2]));
		}

		else if(u.equals(_garr[1],"-cn","--contactName")){
			DB db;
			db.setName(u.str(_garr[2]));
			u.writeln("Kontakt adı: "+u.str(_garr[2]));
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

		else if(_gcount > 2){
			if(u.equals(_garr[1],"-bot","--robot")){
			ui.runPY(robo);
			exit(1);
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

void DB::setName(string name){
	userUI ui;          		 // Istifadeci interfeysi
	ui.sysConfig("contact.name",name);
}

void DB::reg(string user, string pass) {
	userUI ui;          		 // Istifadeci interfeysi
	string up = user+","+pass;      // user and pass
	ui.sysConfig("user.reg",up);
}

void DB::login(string login, string pass) {
	userUI ui;           // Istifadeci interfeysi
	string up = login+","+pass;      // user and pass
	ui.sysConfig("user.reg",up);
		     // 
}

