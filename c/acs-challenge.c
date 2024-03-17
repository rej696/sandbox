#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 4096;

int getRowLength(const char *input[]);
int getColLength(const char *input[]);



int getRowLength(const char *input[])
{
  int count = 0;
  char c;

  // loop over the first row
  // assume all rows in csv are of equal length
  while (**input != '\n')
  {
    // increment the counter for every comma encountered
    if (',' == c)
      ++count;
  }
  return count;
}

int getColLength(const char *input[])
{
  int count = 0;
  char *line = NULL;
  size_t len = 0;
  size_t read;
  
  while ((c = getch()) != EOF)

int main(int argc, const char *argv[])
{
  FILE *fp = fopen("input", "r");

  char line[MAX_LENGTH];
  while(fgets(line, MAX_LENGTH, fp))
  {
    char * 


