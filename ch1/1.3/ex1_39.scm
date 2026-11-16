#!/usr/bin/guile -s
!#
;; Write a procedure (tan-cf x k) that calculates tan(x) by using J.H. Lambert's
;; method by way of a continuous fraction, computing up to the k'th term of the
;; continuous fraction.
;;
;; This exercise gives us a hint at how we might generalize our 'cont-frac'
;; procedure.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-16
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define pi (acos -1))


(define (sqr x) (* x x))


(define (even? x) (= 0 (remainder x 2)))


(define (pow b n)
  (define (iter b n factor)
    (if (= n 1)
        (* b factor)
        (if (even? n)
            (iter (sqr b) (/ n 2) factor)
            ;; Here we do a little optimization, combining a squaring operation
            ;; with an accumulation of the adjustment factor for each odd power
            ;; encountered that is isn't the 1st power.
            (iter (sqr b) (/ (- n 1) 2) (* b factor)))))
  (if (= n 0)
      1
      (iter b n 1)))


(define (decimal-truncate x decimal-pts)
  ;; Truncate a floating-point number or a rational number to a given number of
  ;; decimal places.

  ;; Make sure the starting number is a floating-point number.
  (define num (* 1.0 x))

  ;; Do a base10 left-shift by the desired number of decimal places to which to
  ;; truncate (make these digits come to the left of the decimal period).
  (define shifted-num (* num (pow 10 decimal-pts)))
  ;; Truncate the resulting shifted number.
  (define trunc-num (truncate shifted-num))
  ;; Do a base10 right-shift to the resulting truncated number to reinstate the
  ;; shifted but previously decimal digits back into their initial decimal
  ;; position. Return this as the final result.
  (/ trunc-num (pow 10 decimal-pts)))


(define (test-decimal-truncate)
  ;; Test floating-point numbers.
  (if (= 1234.567 (decimal-truncate 1234.56789 3))
      (display "Truncate a positive floating-point number down to three decimal places: success\n")
      (display "Truncate a positive floating-point number down to three decimal places: FAILURE\n"))
  (if (= -1234.567 (decimal-truncate -1234.56789 3))
      (display "Truncate a negative floating-point number down to three decimal places: success\n")
      (display "Truncate a negative floating-point number down to three decimal places: FAILURE\n"))
  (if (= 1234.0 (decimal-truncate 1234.56789 0))
      (display "Truncate a positive floating-point number down to zero decimal places: success\n")
      (display "Truncate a positive floating-point number down to zero decimal places: FAILURE\n"))
  (if (= -1234.0 (decimal-truncate -1234.56789 0))
      (display "Truncate a negative floating-point number down to zero decimal places: success\n")
      (display "Truncate a negative floating-point number down to zero decimal places: FAILURE\n"))
  ;; Test rational numbers.
  (if (= 1.285 (decimal-truncate 9/7 3))
      (display "Truncate a positive rational number down to three decimal places: success\n")
      (display "Truncate a positive rational number down to three decimal places: FAILURE\n"))
  (if (= -1.285 (decimal-truncate -9/7 3))
      (display "Truncate a negative rational number down to three decimal places: success\n")
      (display "Truncate a negative rational number down to three decimal places: FAILURE\n"))
  (if (= 1.0 (decimal-truncate 9/7 0))
      (display "Truncate a positive rational number down to zero decimal places: success\n")
      (display "Truncate a positive rational number down to zero decimal places: FAILURE\n"))
  (if (= -1.0 (decimal-truncate -9/7 0))
      (display "Truncate a negative rational number down to zero decimal places: success\n")
      (display "Truncate a negative rational number down to zero decimal places: FAILURE\n")))


(define (cont-frac n d k)
  ;; Here we alter the 'cont-frac' procedure to subtract each new fraction in
  ;; the sequence from the Di term, rather than adding it to it. In other words,
  ;; the operation used to accumulate the accumulator is a subtraction rather
  ;; than an addition (perhaps a later exercise will ask us to generalize our
  ;; 'cont-frac' procedure).
  (define (try n d i k accumulator)
    (let ((num (n i))
          (denom (d i)))
      (if (equal? i 1)
          (/ num (- denom accumulator))
          (try n d (- i 1) k (/ num (- denom accumulator))))))
  ;; Start with i = k and accumulator = 0.
  (try n d k k 0))


(define (tan-cf x k)
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   (sqr x)))
             (lambda (i)
               (+ 1 (* 2 (- i 1))))
             k))


(define (tan-approx x)
  (decimal-truncate (tan-cf x 11) 4))


(define (is-main?)
  (let ((filename "ex1_39.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  ;;(test-decimal-truncate)
  (display "tan(pi/4) = ") (display (tan-approx (/ pi 4))) (newline)
  (display "tan(pi) = ") (display (tan-approx pi)) (newline)
  (display "tan(atan(2)) = ") (display (tan-approx (atan 2))) (newline))


(if (is-main?) (main))
