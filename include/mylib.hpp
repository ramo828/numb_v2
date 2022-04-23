#ifndef mylib_hpp
#define mylib_hpp
#include <iostream>
#include <limits.h>
#include <string.h>
#include <sqlite3.h>

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
		#endif
		
		
		string code[3] = {
		"python "+bin+"srcpy/main.py --run robot",
		"python "+bin+"srcpy/main.py --run numb",
		"python "+bin+"srcpy/main.py --run statistic"
		};
		string getBin(){
			return bin;
		}
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

		string split(string str, string spl, int choise){
    			string str1 = str.substr(0, str.find(spl));
    			string str2 = str.substr(str.find(spl)+1, str.length());
    			if(choise == 0)
        			return str1;
    			else if(choise == 1)
        			return str2;
    			else
        			return "";
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
		void runPY(string py);
		void runPY(string py, string args1, string args2);
		void runPY(string py, string args1, string args2, string args3);
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


class DB {
	private:
    	string regSql = "INSERT INTO account VALUES(?,?)";
    	string logSql = "UPDATE account SET user = ? AND pass = ?";
		sqlite3* database; 
		sqlite3_stmt * st;

	public:
		void setAutoStatus(string status);
		void reg(string user, string pass);
		void login(string user, string pass);
		void setName(string name);
		void setHomeDir(string dir);
		void bearerKey(string key);
		void updateBakcellKey(string key);
		void updateNarKey(string key);
		void clearDb(string db);
};

#endif
