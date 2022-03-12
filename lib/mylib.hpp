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
	public:
		//Convert char to string
		string str(char * data){
			return string(data);
		}
		int Target = 0;
		int getDevice();
		void write(string m) {
			cout << m;
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

	public:	
		void sysConfig(string configFile, string configData);
		void runPY(int choise);
};

#endif
