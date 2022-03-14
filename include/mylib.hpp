#ifndef mylib_hpp
#define mylib_hpp
#include <iostream>
#include <limits.h>
#include <string.h>
using namespace std;

class ext {
	private:
	
	public:
		#define robo 0
		#define numb 1
		#define statistic 2
		#define folder ""        //null data
		#if __ANDROID__
			string bin="/data/data/com.termux/files/usr/bin/";
		#elif __linux__
                        string bin="/usr/local/bin/";
		#else
			string bin="/usr/local/bin/";
		#endif
		
		
		string code[3] = {
		"python "+bin+"srcpy/robo.py",
		"python "+bin+"srcpy/numb.py",
		"python "+bin+"srcpy/statistic.py"
		};
};

class fio {
	private:
		string _file;
	public:
		fio(string file){
			_file = file;
		}
		int makeDir(string folderName);
		void openFile();
		void writeFile(string data);
		string readFile();
};
class util {
	private:
		int androidVar = 0;
		int linuxVar = 1;
		//int _robotMsgCount = 0;
	public:
		//Convert char to string
		string str(char * data){
			return string(data);
		}
		string str(int data){
			return to_string(data);
		}
		int toInt(string s) {
			int i;
			i = stoi(s);
			return i;
		}
			int Target = 0;
		int getDevice();
		void write(string m) {
			cout << m;
		}
		bool equals(char *cdata, string sdata1,string sdata2) {
			if(str(cdata) == sdata1 || str(cdata) == sdata2) 
				return true;
			else
				return false;
		}
		void writeln(string m) {
			cout << m << endl;
		}
	// Linux, Windows ve Androidde esas sehifeni gosterir
	// meselen /home/ramo828
		char *get_homedir(void) {
    			char homedir[PATH_MAX];
			#ifdef _WIN32
    				snprintf(homedir, PATH_MAX, "%s%s", getenv("HOMEDRIVE"), getenv("HOMEPATH"));
			#else
    				snprintf(homedir, PATH_MAX, "%s", getenv("HOME"));
			#endif
    				return strdup(homedir);
		}

};

class userUI {
	private:
		string key;
		int _robotMsgCount;

	public:	
		void sysConfig(string configFile, string configData);
		void runPY(int choise);
		void setMsg(int robotMsgCount){
			_robotMsgCount = robotMsgCount;
		}
		void getMsg(){
			util u;
			u.writeln(u.str(_robotMsgCount));	
		}
};

class run {
	private:
		int _gcount;
		char ** _garr;
	public:
		run(int gcount, char ** garr) {
			_gcount = gcount;
			_garr = garr;
		}
		void runner();

};

#endif
