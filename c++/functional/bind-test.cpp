#include <algorithm>
#include <functional>
#include <iostream>
#include <sstream>
#include <list>

typedef std::function<int (int)> callback; 
typedef std::list<callback> listeners;

class listener
{
 public:
  int on(int e)
  {
    std::cout
        << "listener::on("
        << e
        << ") => "
        << e
        << std::endl;

    return e;
  }
};

int main(int argc, char* argv[])
{
  if(argc != 2)
  {
    std::cout << argv[0] << " <number>" << std::endl;
    return EXIT_FAILURE;
  }

  std::stringstream ss(argv[1]);

  int e = 0;
  ss >> e;

  using namespace std::placeholders;
  listeners xs;
  listener the_listener;
  xs.push_back(std::bind(&listener::on, &the_listener, _1));

  std::for_each(xs.begin(), xs.end(), [&e](auto x) { x(e); });
  return EXIT_SUCCESS;
}

