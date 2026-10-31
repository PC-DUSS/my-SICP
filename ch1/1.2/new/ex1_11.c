#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <stdint.h>
#include <time.h>


#define NUMBER 33


uint64_t recursive_f(uint8_t n);
uint64_t iterative_f(uint8_t n);
uint64_t iterate(uint8_t count, uint64_t a, uint64_t b, uint64_t c);


int main(void) {
    //struct timeval *t1 = malloc(sizeof(struct timeval));
    //struct timeval *t2 = malloc(sizeof(struct timeval));

    //gettimeofday(t1, NULL);
    clock_t t1 = clock();
    uint64_t recurse_result = recursive_f(NUMBER);
    //gettimeofday(t2, NULL);
    clock_t t2 = clock();
    //suseconds_t recurse_timedelta = t2->tv_usec - t1->tv_usec;
    long recurse_timedelta = t2 - t1;

    //gettimeofday(t1, NULL);
    t1 = clock();
    uint64_t iterate_result = iterative_f(NUMBER);
    //gettimeofday(t2, NULL);
    t2 = clock();
    //suseconds_t iterate_timedelta = t2->tv_usec - t1->tv_usec;
    long iterate_timedelta = t2 - t1;

    printf("Recursive: f(%d) = %ld Time = %ld microseconds\n",
           NUMBER, recurse_result, recurse_timedelta);
    printf("Iterative: f(%d) = %ld Time = %ld microseconds\n",
           NUMBER, iterate_result, iterate_timedelta);

    /* Free memory */
    //free(t1);
    //free(t2);

    return 0;
}


uint64_t recursive_f(uint8_t n) {
    if (n < 3) {
        return n;
    }
    return recursive_f(n - 1)
        + 2 * recursive_f(n - 2)
        + 3 * recursive_f(n - 3);
}


uint64_t iterative_f(uint8_t n) {
    return iterate(n, 2, 1, 0);
}


uint64_t iterate(uint8_t count, uint64_t a, uint64_t b, uint64_t c) {
    if (count < 3) {
        return count;
    } else if (count == 3) {
        return a + 2 * b + 3 * c;
    }
    return iterate(count - 1, a + 2 * b + 3 * c, a, b);
}
