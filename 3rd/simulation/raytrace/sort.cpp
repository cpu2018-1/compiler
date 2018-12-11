#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <map>
using namespace std;

vector<pair<int,string> > v;

int main(){
  v = vector<pair<int,string> >();
  string str;
  int dbl;
  while(cin >> str >> dbl){
    v.push_back(make_pair(dbl,str));
  }
  sort(v.begin(),v.end());
  for(int i = 0; i < v.size(); i++){
    cout << v[i].second << " " << v[i].first << endl;
  }
  return 0;
}
