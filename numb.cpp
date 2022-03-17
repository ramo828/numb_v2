#include <iostream>
#include "include/mylib.hpp"
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
	userUI ui;
	util u;
	ui.sysConfig("default.dir",u.get_homedir());
	run r(argc, argv);
	r.runner();
	return 0;
}
