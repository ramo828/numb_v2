#include <iostream>
#include "include/mylib.hpp"
#include "include/conn.hpp"
#include <string>
using namespace std;

connDB cd;


int main(int argc, char *argv[]) {
	userUI ui;
	util u;
	cout << u.split("Ramiz,Memmedli",",",1) <<endl;
	string login;
	string pass;
    	cout << endl <<"Login: ";
	cin >> login;
	cout <<"Password: ";
	cin >> pass;
	if(cd.checkUserAndPass(login,pass)) {
		cout << endl << "Hesabiniza giris edildi" << endl;
	if(cd.checkUserStatus(login, pass)) {
            cout << "Status: Aktiv" << endl;
		ui.runPY(numb);
	}
        else
            cout << "Status: Passiv" << endl;
	}
	else
		cout << endl << "Login ve ya parol yanlisdir" << endl;
	//run r(argc, argv);
	//if(u.equals(argv[1],"-robo","--robot") && argc >2)
	//	ui.setMsg(u.toInt(u.str(argv[2])));
	//ui.getMsg();
	//ui.sysConfig("default.dir",u.get_homedir());
	//ui.sysConfig("user.status","1");
	//r.runner();
	return 0;
}
