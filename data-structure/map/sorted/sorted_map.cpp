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

void print(const index_element& e) {
  cout << "(" << e.first << ", '" << e.second << "')" << endl;
}

int main(int argc, char* argv[]) {
  index idx1 = index();
  index idx2 = index();

  idx1.insert(index_element(4, "Babe"));
  idx1.insert(index_element(3, "Cafe"));
  idx1.insert(index_element(2, "World"));
  idx1.insert(index_element(1, "Hello"));
  idx1.insert(index_element(0, "The C++ Programming Language"));

  idx2.insert(index_element(7, "Sleepy"));
  idx2.insert(index_element(5, "Donald"));
  idx2.insert(index_element(8, "Joe"));
  idx2.insert(index_element(6, "Trump"));

  list<index_element> merged_idx = list<index_element>();

  merge(idx1.begin(), idx1.end(),
        idx2.begin(), idx2.end(),
        //insert_iterator<list<index_element> >(merged_idx, merged_idx.begin()));
        inserter(merged_idx, merged_idx.begin()));

  for_each(merged_idx.begin(), merged_idx.end(), print);

  return 0;
}

