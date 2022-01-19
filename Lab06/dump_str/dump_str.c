#include <stdio.h>
int main()
{
	char *inputStr = "Hello World\n";

	FILE *fp;

	fp = fopen("data.coe", "w+");
	fprintf(fp, "memory_initialization_radix  = 16\n"
				"memory_initialization_vector =\n");
	char *ptr = inputStr;
	while (*ptr != 0)
		fprintf(fp, "%08x\n", *ptr++);
	fclose(fp);
}