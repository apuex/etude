#include <Location.h>
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

  if(!file.Open(argv[1], CFile::modeCreate | CFile::modeWrite)) {
    std::cout << "Unable to open file: "
	      << argv[1] << std::endl;
    AFXDUMP(_T("Unable to open file."));
    exit(1);
  }

  CArchive archive(&file, CArchive::store);

  CLocation point(-456, -123);

  // point.Serialize(archive);
  archive << &point;

  return EXIT_SUCCESS;
}

