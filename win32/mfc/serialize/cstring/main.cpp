#include <afx.h>
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
    exit(1);
  }

  CArchive archive(&file, CArchive::store);

  CString person("Wangxy");

  archive << person;

  return EXIT_SUCCESS;
}

