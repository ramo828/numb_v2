#include "../include/mylib.hpp"
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std; 

// Fayl input/output
void fio::openFile() {
	ofstream outfile;
	outfile.open(_file);
	outfile.close();
}

void fio::writeFile(string data) {
	ofstream outfile;
	outfile.open(_file);
	outfile << data;
	outfile.close();
}

int fio::makeDir(string folderName){
	int status = mkdir(folderName.c_str(),0777);	
	if(status != 0)
	       	return 0;
	else
		return 1; 	

}
// Python kodlarini calisdirmaq
void userUI::runPY(int choise) {
	util u;
	ext e;
	switch(choise) {
		case 0: system(e.code[0].c_str()); // Robo
			break;
		case 1:
			system(e.code[1].c_str()); // Numb
			break;
		case 2:
			system(e.code[2].c_str()); //Statistic
			break;
		//case 3:
		default: u.writeln("Bilinmeyen emr!");
	}
}


// Python kodlarini calisdirmaq
void userUI::runPY(string py) {
	string py1 = "python "+py;
	system(py1.c_str());
}


// Python kodlarini calisdirmaq
void userUI::runPY(string py, string args1, string args2) {
	string py1 = "python "+py+" "+args1+" "+args2;
	system(py1.c_str());
}

void userUI::runPY(string py, string args1, string args2, string args3) {
	string py1 = "python "+py+" "+args1+" "+args2 +" "+args3;
	system(py1.c_str());
}

void userUI::sysConfig(string configFile,string configData){
	fio cfol(folder);
	fio cfil(".config/"+configFile);
	cfol.makeDir(".config");
	cfil.writeFile(configData);
}

int util::getDevice() {

			userUI ui;
			#if __ANDROID__
                		writeln("\n-----------OS: Android----------");
                		Target = androidVar;
                	#elif __linux__
                		writeln("\n-----------OS: Linux-----------");
                		Target = linuxVar;
                		#elif __UNIX__
                		writeln("\n-----------Unix secildi-----------");
                		#endif
		return Target;
}
