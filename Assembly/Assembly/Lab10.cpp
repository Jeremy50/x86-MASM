#include <iostream>
#include <fstream>
using namespace std;

int main(int argcount, char* args[]) {

	if (argcount < 4) {
		cout << "Usage: Encode <infile> into <outfile>, then decodes <outfile> into <decodedfile>" << endl;
		return -1;
	}

	const int BUFSIZE = 2000;
	char buffer[BUFSIZE];
	unsigned int count;

	unsigned char encryptCode;
	cout << "Encryption Code [0-255]: ";
	cin >> encryptCode;

	ifstream infile(args[1], ios::binary);
	ofstream outfile(args[2], ios::binary);

	cout << "Reading " << args[1] << " and creating " << args[2] << endl;
	while (!infile.eof()) {
		infile.read(buffer, BUFSIZE);
		count = infile.gcount();
		
		__asm {
			lea esi, buffer
			mov ecx, count
			mov al, encryptCode
			L1:
				xor [esi], al
				inc esi
				loop L1
		}
		
		outfile.write(buffer, count);
	}
	infile.close();
	outfile.close();

	char buffer2[BUFSIZE];
	ifstream infile2(args[2], ios::binary);
	ofstream outfile2(args[3], ios::binary);

	cout << "Reading " << args[2] << " and creating " << args[3] << endl;
	while (!infile2.eof()) {
		infile2.read(buffer2, BUFSIZE);
		count = infile2.gcount();
		
		__asm {
			lea esi, buffer2
			mov ecx, count
			mov al, encryptCode
			L2:
			xor [esi], al
				inc esi
				loop L2
		}
		
		outfile2.write(buffer2, count);
	}
	infile2.close();
	outfile2.close();

	return 0;
}