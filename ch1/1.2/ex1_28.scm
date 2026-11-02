#!/usr/bin/guile -s
!#
;; Implement the Miller-Rabin test (based on the Fermat test) which tests
;; quickly for primality, but cannot be fooled, unlike the Fermat test. It
;; efficiently detects odd composite numbers, and all odd prime numbers pass
;; (n >= 3).
;;
;; Theorem:
;; For any prime number n,
;; a^(n-1) mod n = 1 mod n
;; -> a^(n-1) mod n = 1
;;
;; Additionally, whenever we square, we should check if the result mod n is
;; equal to 1. If it is, then n is not prime since this means we have found a
;; factor of n.
;;
;; A composite number will fool the test for at most 1/4 of possible
;; a-values. Then, testing for a-values up to n/4 + 1 should provide 100%
;; success rate at detecting only primes (since this would produce at least one
;; true negative, showing that the number is not prime).
;;
;; More info: https://math.gordon.edu/ntic/ntic/section-sqrt-mod-n-lemma.html
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-31
;;
;; Code:
(load "/home/pcduss/Documents/programs/lisp/scheme/my-lib/assert/assert.scm")

(define (even? x)
  (= (remainder x 2) 0))


(define (square x)
  (* x x))


(define (old-expmod a pow n)
  (cond ((= pow 0) 1)
        ((even? pow) (remainder (square (old-expmod a (/ pow 2) n)) n))
        (else (remainder (* a (old-expmod a (- pow 1) n)) n))))


(define (expmod a pow n)
  (cond ((= pow 0) 1)
        ((even? pow) (begin
                       (define x (expmod a (/ pow 2) n))
                       (define sq-mod (remainder (square x) n))
                       (if (and (= sq-mod 1) (not (= x 1)) (not (= x (- n 1))))
                           0  ;; Then n is not prime. Return 0.
                           sq-mod)))  ;; Then n still has a chance to be prime. Continue.
        (else (remainder (* a (expmod a (- pow 1) n)) n))))


(define (mrt-iter a n)
  ;; The line below is more efficient while also being accurate at only
  ;; detecting true primes, however SICP does not ask for this method so we
  ;; leave it commented.
  ;;
  ;;(cond ((> a (/ n 4)) #t)
  (cond ((> a (- n 1)) #t)
        ((= (expmod a (- n 1) n) 1) (mrt-iter (+ a 1) n))
        (else #f)))


(define (miller-rabin-test n)
  (mrt-iter 2 n))


(define (prime-test x)
  (display (string-append (number->string x)
                          ": "
                          (if (miller-rabin-test x) "prime\n" "not prime\n"))))


(define (run)
  (define carmichael-numbers (list 3 11 13 561 1105 1729 2465 2821 6601))
  (display "Miller-Rabin primality test:\n")
  (for-each prime-test carmichael-numbers))


(define (main)
  (run))


(main)

