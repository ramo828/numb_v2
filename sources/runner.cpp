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

				ui.runPY("python "+e.bin+"srcpy/main.py --reg "+user+" "+pass);
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

void DB::reg(string user, string pass) {
	userUI ui;          		 // Istifadeci interfeysi
	string up = user+","+pass;      // user and pass
	ui.sysConfig("user.reg",up);
}


void DB::login(string login, string pass) {
	//userUI ui;           // Istifadeci interfeysi
	//ui.sysConfig("user.reg",login+","+pass);
}

