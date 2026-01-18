#include <cstddef>
#include <iostream>
#include <regex>
#include <string>

int
main
( int argc
, char* argv[]
)
{
  const std::regex re(R"(([^Xx]*)([Xx]{1,2})([^Xx]*))");
  std::smatch match;

  std::string s = "moduleX";
  if(argc > 1)
  {
    s = argv[1];
  }

  if(std::regex_search(s, match, re))
  {
    std::cout
        << "s=\"" << s <<"\""
        << std::endl;
    for(size_t n = 0; n != match.size(); ++n)
    {
      std::cout
          << "match[" << n << "] = " << match[n]
          << std::endl;
    }
  }

  return EXIT_SUCCESS;
}

