#include <Person.h>
#include <iostream>
#include <cstdlib>

int main(int argc, char* argv[]) {

  if(argc < 2) {
    std::cout << "Usage:" << std::endl
	      << argv[0]  << " <file>"
	      << std::endl;
    return EXIT_FAILURE;
  }
  
  CFile file;
  int count = MultiByteToWideChar(CP_ACP, 0, argv[1], strlen(argv[1]), NULL, 0);
  
  if(count < 1) {
    AFXDUMP(_T("Get file name length with MultiByteToWideChar failed."));
    std::cout << "Get file name length with MultiByteToWideChar failed." << std::endl;
    exit(4);
  }

  std::cout << "File name length is: " << count << std::endl;
  TCHAR* fileName = new TCHAR[count + 1];
  int size = MultiByteToWideChar(CP_ACP
		  , 0
		  , argv[1]
		  , -1
		  , fileName
		  , count + 1
		  );
  DWORD err = GetLastError();

  if(err != 0) {
    AFXDUMP(_T("Convert file name with MultiByteToWideChar failed."));
    std::cout << "Convert file name with MultiByteToWideChar failed, err: " << err << std::endl;
    exit(3);
  }

  if(size == 0) {
    std::cout << "Convert file name with MultiByteToWideChar failed, size: " << size << std::endl;
    exit(2);
  } else {
    std::cout << "Convert file name with MultiByteToWideChar successful, size: " << size << std::endl;
  }

  if(!file.Open(fileName, CFile::modeCreate | CFile::modeWrite)) {
    std::cout << "Unable to open file: "
	      << fileName << std::endl;
    AFXDUMP(_T("Unable to open file."));
    exit(1);
  }

  CArchive archive(&file, CArchive::store);

  CPerson person("Wangxy", 123);

  person.Serialize(archive);

  return EXIT_SUCCESS;
}

