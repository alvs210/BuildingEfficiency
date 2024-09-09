#include <stdlib.h>
#include <stdio.h>

int fib(int N) {

    if (N == 0) {
        return 2;
    }

    else {
    int X = (3 * (N-1)) + fib(N-1) + 1;

    return X;
    }

}

int main(int argc, char* argv[]) {

    long N = strtol(argv[1], NULL, 10);


    if (N < 0) {
        printf("ERROR: Number Below Zero! Input Positive Number Instead");
    }
   
    // int X = 3 * fib(N-1) + (N) + 1;
    int X = fib(N);

    printf("%d\n", X);
 
    return EXIT_SUCCESS;

}





//REMEMBER THE PHOTO CREDIT
