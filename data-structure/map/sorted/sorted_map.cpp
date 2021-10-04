#include <algorithm>
#include <iostream>
#include <iterator>
#include <list>
#include <map>
#include <string>

using namespace std;

typedef pair<int, string> index_element;
typedef map<int, string> index;

bool operator < (const index_element& lhs, const index_element& rhs) {
  return (lhs.first < rhs.first);
}

int main(int argc, char* argv[]) {
  index idx1 = index();
  index idx2 = index();

  idx1.insert(make_pair(4, "Babe"));
  idx1.insert(make_pair(3, "Cafe"));
  idx1.insert(make_pair(2, "World"));
  idx1.insert(make_pair(1, "Hello"));
  idx1.insert(make_pair(0, "The C++ Programming Language"));

  idx2.insert(make_pair(7, "Sleepy"));
  idx2.insert(make_pair(5, "Donald"));
  idx2.insert(make_pair(8, "Joe"));
  idx2.insert(make_pair(6, "Trump"));

  list<index_element> merged_idx = list<index_element>();

  merge(idx1.begin(), idx1.end(),
        idx2.begin(), idx2.end(),
        //insert_iterator<list<index_element> >(merged_idx, merged_idx.begin()));
        inserter(merged_idx, merged_idx.begin()));

  for_each(merged_idx.begin(), merged_idx.end(), [] (const index_element& e) {
      cout << "(" << e.first << ", '" << e.second << "')" << endl;
    });

  return 0;
}

