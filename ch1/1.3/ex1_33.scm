#!/usr/bin/guile -s
!#
;; Write an even more generalized version of 'accumulate' called
;; 'filter-accumulate' that accepts an additional argument 'filter'. The
;; argument passed as 'filter' should be a predicate that is applied to each
;; value a to decide whether or not to apply term to a and to accumulate the
;; result, or to ignore this a and move on to the next a. Then, show how to
;; express the following using your new 'filter-accumulate' procedure:
;;
;; a) the sum of all the squares of the prime numbers in the interval [a; b].
;;
;; b) the product of all the positive integers less than n that are relatively
;;    prime to n (a.k.a. coprime to n). In other words, for which the GCD
;;    between that positive integer and n is 1.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-02
;;
;; Copyright 2026 Pierre C. Dussault. See the LICENSE file for details.
;;
;; Code:
(define (identity x) x)


(define (square x) (* x x))


(define (inc x) (+ x 1))


(define (even? x) (= (remainder x 2) 0))


(define (miller-rabin x)
  (define (expmod base pow mod)
    ;; expmod implementation specific to the Miller-Rabin test.
    (cond ((= pow 0) 1)
          ((even? pow)
           (define sq-mod (remainder (square (expmod base (/ pow 2) mod)) mod))
           (if (= sq-mod 1) 0 sq-mod))
          (else (remainder (* base (expmod base (- pow 1) mod)) mod))))

  (define (mrt-iter a n)
    (cond ((> a (/ n 4)) #t)
          ((= (expmod a (- n 1) n) 1) (mrt-iter (+ a 1) n))
          (else #f)))

  (mrt-iter 2 x))


(define (prime? x)
  (miller-rabin x))


(define (filter-accumulate combiner null-value filter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
          ;; Accumulate this 'a' and move on to the next 'a'.
          (iter (next a) (combiner (term a) result))
          ;; Skip this 'a' and move on to the next 'a'.
          (iter (next a) result))))

  (iter a null-value))


(define (sum term a next b)
  ;; This filter will accept all 'a's.
  (filter-accumulate + 0 (lambda (x) #t) term a next b))


(define (product factor a next b)
  ;; This filter will accept all 'a's.
  (filter-accumulate * 1 (lambda (x) #t) factor a next b))


(define (filter-sum filter term a next b)
  (filter-accumulate + 0 filter term a next b))


(define (filter-product filter factor a next b)
  (filter-accumulate * 1 filter factor a next b))


(define (sum-primes-square a b)
  (filter-accumulate + 0 prime? square a inc b))


(define (product-coprimes n)
  (define (coprime? x)
    (define (gcd a b)
      ;; Eucledian algorithm.
      (if (= b 0)
          a
          (gcd b (remainder a b))))

    ;; Return #t if the GCD between x and n is equal to 1.
    (define a (max x n))
    (define b (min x n))
    (= 1 (gcd a b)))

  (filter-accumulate * 1 coprime? identity 1 inc n))


(define (main)
  (display "sum-even[1-6] = ")
  (display (filter-sum (lambda (x) (even? x)) identity 1 inc 6))
  (newline)

  (display "sum-odd[1-6] = ")
  (display (filter-sum (lambda (x) (not (even? x))) identity 1 inc 6))
  (newline)

  (display "product-even[1-6] = ")
  (display (filter-product (lambda (x) (even? x)) identity 1 inc 6))
  (newline)

  (display "product-odd[1-6] = ")
  (display (filter-product (lambda (x) (not (even? x))) identity 1 inc 6))
  (newline)

  (display "sum of squares of primes from [1-25] = ")
  (display (sum-primes-square 1 25))
  (newline)

  (display "product of positive integers that are coprime with 20, from [1-20] = ")
  (display (product-coprimes 20))
  (newline))


(main)
