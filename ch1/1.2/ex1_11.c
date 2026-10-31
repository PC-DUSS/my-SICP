/* Compare the performance of a recursive process vs iterative process for
   implementations of a Fibonacci number function. Can also be used to compare
   the performance of the two implementations in C with their respective
   performance in GNU Guile.

   Author: Pierre C. Dussault
   Date: 2026-10-29
*/
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
    clock_t t1, t2;
    uint64_t recurse_result, iterate_result, recurse_timedelta,
        iterate_timedelta;

    t1 = clock();
    recurse_result = recursive_f(NUMBER);
    t2 = clock();
    recurse_timedelta = t2 - t1;

    t1 = clock();
    iterate_result = iterative_f(NUMBER);
    t2 = clock();
    iterate_timedelta = t2 - t1;

    printf("Recursive: f(%d) = %ld Time = %ld microseconds\n",
           NUMBER, recurse_result, recurse_timedelta);
    printf("Iterative: f(%d) = %ld Time = %ld microseconds\n",
           NUMBER, iterate_result, iterate_timedelta);

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
