#include <iostream>
#include "include/mylib.hpp"
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
	userUI ui;
	util u;
	
		if(u.getDevice())
		ui.sysConfig("default.dir",u.get_homedir());
	else
		ui.sysConfig("default.dir","/sdcard/work");
	run r(argc, argv);
	r.runner();
	return 0;
}
