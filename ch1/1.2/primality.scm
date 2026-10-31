#!/usr/bin/guile -s
!#
;; Testing for primality.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-30
;;
;; Code:
(define (main)
  ;; Helper functions
  (define (even? x)
    (if (= (remainder x 2) 0) #t #f))
  (define (sqr x)
    (* x x))
  (define (pow base power)
    (define (pow-iter base power total)
      (cond ((= power 0) total)
            ((even? power) (pow-iter (sqr base) (/ power 2) total))
            (else (pow-iter base (- power 1) (* base total)))))
    (pow-iter base power 1))
  (define (expmod base power m)
    (if (= power 0)
        1
        (remainder (pow base power) m)))
  ;; One way to test for primality is to successively test for possible integer
  ;; divisors from the bottom up, starting with the number 2 (we don't test for
  ;; divisibility by 1, because that is obvious) up to the dividend (the number
  ;; being divided) itself. Since we only need to test for possible divisors
  ;; from 2 to sqrt(n), that means that this algorithm will have sqrt(n) steps.
  ;; In other words, it has a time complexity of O(sqrt(n)).
  (define (smallest-divisor n)
    (define (divides? a b)
      (= (remainder a b) 0))
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))
  (define (prime? n)
    (= (smallest-divisor n) n))
  ;; Now we will take a look at Fermat's Little Theorem:
  ;; <<If 'n' is a prime number and 'a' is any positive integer less than 'n',
  ;; then 'a' raised to the n'th power is congruent to 'a' modulo 'n'.>>
  ;;
  ;; This means, mathematically, that:
  ;; a^n % n = a % n          and since a < n,
  ;; a^n % n = a
  (define (fermat-test n)
    (define a 0)
    (cond ((< n 2) #f)
          (else
            (set! a (+ (random (- n 1)) 1))
            (= (expmod a n n) a))))

  (define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else #f)))

  (display (fast-prime? 3 3)) (newline))


(main)

