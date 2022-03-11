#include <iostream>
#include "lib/mylib.hpp"
#include <string>
using namespace std;
int main(int argc, char *argv[]) {
	userUI ui;
	util u;
	ui.sysConfig("default.dir",u.get_homedir());
	ui.sysConfig("user.status","1");
	if(u.getDevice())
		u.writeln("Linux");
	else
		u.writeln("Android");
	if(u.str(argv[1]) == "numb")
		ui.runPY(numb);
	else if(u.str(argv[1]) == "robot")
		ui.runPY(robo);
	else 
		u.writeln("Taninamayan: "+u.str(argv[1]));	
	return 0;
}
