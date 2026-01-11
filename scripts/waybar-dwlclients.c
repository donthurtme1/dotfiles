#!/bin/env -S tcc -run
#include <fcntl.h>
#include <stdio.h>

int main() {
	FILE *dwloutput = fopen("/home/basil/.cache/dwloutput", "r");
	if (dwloutput == NULL) {
		perror("fopen");
		return 1;
	}

	char *line;
	size_t len;
	getline(&line, &len, dwloutput);
	printf("%s", line);

	fclose(dwloutput);
	return 0;
}
