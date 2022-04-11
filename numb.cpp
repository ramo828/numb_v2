#include <iostream>
#include "include/mylib.hpp"
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
	DB db;
	util u;
	if(u.getDevice())
		db.setHomeDir(u.get_homedir()); // Linux
	else
		db.setHomeDir("/sdcard/work/"); // Android
	run r(argc, argv);
	r.runner();
	return 0;
}
