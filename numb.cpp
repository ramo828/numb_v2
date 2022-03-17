#include <iostream>
#include "include/mylib.hpp"
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
	userUI ui;
	util u;
	run r(argc, argv);
	//if(u.equals(argv[1],"-robo","--robot") && argc >2)
	//	ui.setMsg(u.toInt(u.str(argv[2])));
	//ui.getMsg();
	//ui.sysConfig("default.dir",u.get_homedir());
	//ui.sysConfig("user.status","1");
	r.runner();
	return 0;
}
