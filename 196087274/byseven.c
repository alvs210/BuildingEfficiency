#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]) {

    long N = strtol(argv[1], NULL, 10);

    int i = 1;

    //if (argv[1] == NULL) {
  //      perror("ERROR: No Number Input! Put a number");
  //  }

    while (i <= N) {
        int Z = 7 * i;
        printf("%d\n", Z);
        i++;
    }


    return EXIT_SUCCESS;
}