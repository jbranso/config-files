#include <studio.h>
#include <string.h>

#define MAXLINES 5000
char *lineptr [MAXLINES];

int  readlines (char *lineptr [], int nlines);
void writelines (char *lineptr [], int nlines);

void qsort (void *lineptr [], int left, int right,
            int (*comp) (void *, void *));
