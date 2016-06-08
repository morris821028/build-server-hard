#include <bits/stdc++.h>
using namespace std;
#define MAXN 16777216
#define MAXB (1<<26)
char line[MAXN], buffer[MAXB];
char *bptr = buffer;
void writeFile(const char *s, char padding) {
	for (; *s; s++, bptr++)
		*bptr = *s;
	*bptr = padding, bptr++;
	if (bptr >= buffer + MAXB - 10000) {
		*bptr = '\0';
		fputs(buffer, stdout);
		bptr = buffer;
	}
}
int main() {
	unordered_map<string, pair<int, int> > R;
    while (fgets(line, MAXN-1, stdin)) {
        int len = strlen(line);
        if (line[len-1] == '\n')
            line[len-1] = 0;
        char *p, *q;
        p = strtok(line, " \t");
		q = strtok(NULL, " \t");
		if (p != NULL && q != NULL) {
			pair<int ,int> &t = R[p];
			t.first += atoi(q), t.second ++;
//			fputs(p, stdout), putchar('\t'), fputs(q, stdout), fputs("\t1\n", stdout);
		}
    }

	for (auto &x : R) {
		static char fbuf[128];
		writeFile(x.first.c_str(), '\t');
		sprintf(fbuf, "%d", x.second.first);
		writeFile(fbuf, '\t');
		sprintf(fbuf, "%d", x.second.second);
		writeFile(fbuf, '\n');
//		fputs(x.first.c_str(), stdout), putchar('\t');
//		printf("%d\t%d\n", x.second.first, x.second.second);
	}
	*bptr = '\0';
	fputs(buffer, stdout);
    return 0;
}
