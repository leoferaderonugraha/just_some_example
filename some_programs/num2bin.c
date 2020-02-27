#include <stdio.h>
#include <math.h>
#include <stdlib.h>


int main(){
  int usrInput;

  fprintf(stdout, "Angka: ");
  scanf("%d", &usrInput);

  //int length = floor(log10(abs(usrInput))); // get the length of the user input
  int *binary = (int *) malloc(sizeof(int) * 256);
  int index = 0;


  for(; usrInput > 0; usrInput /= 2, index++){
    binary[index] = usrInput & 1; // sama kaya itu % 2;
    printf("-%d-%d-\n", index, binary[index]); // simpen di array
  }

  for(index -= 1; index >= 0; index--)
    printf("%d", binary[index]); // tampilin dengan urutan yg benar

  puts("");
  free(binary);
}
