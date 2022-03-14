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
		else if(_gcount > 2){
			if(u.equals(_garr[1],"-bot","--robot")){
			ui.runPY(robo);
			exit(1);
			}
	
		}
		else {
			u.writeln("Taninamayan: "+u.str(_garr[1]));
			u.writeln("ok");
			exit(1);

		}
	}
	else {
			ui.runPY(numb);
			exit(1);
	}

}

