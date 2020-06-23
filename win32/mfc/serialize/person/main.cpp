#include <Person.h>
#include <iostream>
#include <cstdlib>

int main(int argc, char* argv[]) {

  if(argc < 2) return EXIT_FAILURE;
  
  CFile file;
  
  if(!file.Open(argv[1], CFile::modeCreate | CFile::modeWrite)) {
    AFXDUMP(_T("Unable to open file."));
    exit(1);
  }

  CArchive archive(file, CArchive::store);

  CPerson person("Wangxy", 123);

  person.Serialize(archive);

  return EXIT_SUCCESS;
}

