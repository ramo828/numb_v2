#include <iostream>
#include "include/mylib.hpp"
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
	DB db;                              // Call db class 
	util u;                             // Call util class
	if(u.getDevice())                   // Detect device
		db.setHomeDir(u.get_homedir()); // Linux
	else
		db.setHomeDir("/sdcard/work/"); // Android
	run r(argc, argv);                  // argument
	r.runner();                         // call runner
	return 0;
}
