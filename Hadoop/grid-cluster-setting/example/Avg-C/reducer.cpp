#include <bits/stdc++.h>
using namespace std;

#define MAXN 16777216
static char line[MAXN], strKey[MAXN];
int main() {
    int total = 0, count = 0;
	unordered_map<string, pair<int, int> > R;
    while (fgets(line, MAXN-1, stdin)) {
        int len = strlen(line);
        char *p, *q, *r;
        int n, m;
        p = strtok(line, " \r\n\t");
		q = strtok(NULL, " \r\n\t");
        r = strtok(NULL, " \r\n\t");
		if (p == NULL || q == NULL || r == NULL)
			continue;
        n = atoi(q), m = atoi(r);
		pair<int, int> &t = R[p];
		t.first += n, t.second += m;
    }
	map< string, pair<int, int> > Q;
	for (auto &x : R)
		Q[x.first] = x.second;
	for (auto &x : Q)
		printf("%s\t%lf\n", x.first.c_str(), (float) x.second.first / x.second.second);
	return 0;
}
