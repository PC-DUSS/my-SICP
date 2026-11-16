#!/usr/bin/guile -s
!#
;; a) Define a procedure 'cont-frac' such that evaluating (cont-frac a d k)
;;    computes the value of the k-term finite continued fraction. Check your
;;    procedure by approximating 1/golden_ratio using:
;;
;;      (cont-frac (lambda (i) (1.0)) (lambda (i) (1.0)) k)
;;
;;    for successive values of k. How large must you make k in order to get an
;;    approximation that is accurate to 4 decimal places?
;;
;; b) If your 'cont-frac' procedure generates a recursive process, write another
;;    version that generates an iterative process instead, or vice-versa.
;;
;; Reminder, golden_ratio = 1.6180 (approx.).
;; Therefore, 1/golden_ratio = 0.6180 (approx.).
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-15
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (cont-frac n d k)
  (define (try n d i k)
    (let ((num (n i))
          (denom (d i)))
      (if (equal? i k)
          (/ num denom)
          (/ num (+ denom (try n d (+ i 1) k))))))
  ;; Start with i = 1.
  (try n d 1 k))


(define (cont-frac-iter n d k)
  ;; We will go in decreasing from i = k until i = 1. This allows us to avoid
  ;; latent division computations which would result in a recursive process.
  (define (try-iter n d i k accumulator)
    (let ((num (n i))
          (denom (d i)))
      (if (equal? i 1)
          (/ num (+ denom accumulator))
          (try-iter n d (- i 1) k (/ num (+ denom accumulator))))))
  ;; Start with i = k and accumulator = 0.
  (try-iter n d k k 0))


(define (is-main?)
  (let ((filename "ex1_37.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  ;; Both implementations give sufficient accuracy when k = 11.
  (display "Recursive process result = ")
  (display (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11))
  (newline)
  (display "Iterative process result = ")
  (display (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11))
  (newline))


(if (is-main?) (main))


;; We can see in this exercise that the way to generate a recursive process
;; requires us to go from i=1 to i=k in increasing order (to preserve latent
;; division computations), whereas the iterative solution requires us to go in
;; decreasing order, from i=k to i=1 to avoid latent division computations so as
;; to be able to accumulate values iteratively inside an accumulator variable.
;; There is perhaps a way to accomplish each version in the opposite order, but
;; the method is likely much more complex.

