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


(define (is-main?)
  (let ((filename "ex1_39.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (display "tan(pi/4) = ") (display (tan-cf (/ pi 4) 25)) (newline)
  (display "tan(pi) = ") (display (tan-cf pi 25)) (newline))


(if (is-main?) (main))
