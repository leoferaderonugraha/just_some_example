#include <stdio.h>
#include <string.h>

int main(){
  char userInput[10];
  printf("Password: ");
  scanf("%s", &userInput);
  if(strcmp(userInput, "root") == 0)
    puts("Access Granted...");
  else
    puts("Denied!!!");
}
