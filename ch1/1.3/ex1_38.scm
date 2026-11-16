#!/usr/bin/guile -s
!#
;; Use the 'cont-frac' procedure to calculate the continuous fraction where
;; Ni = 1.0 and Di = number i from Euler's sequence. The result of this
;; continuous fraction should be (e - 2), or approx. 0.718.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-15
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (cont-frac n d k)
  (define (try n d i k accumulator)
    (let ((num (n i))
          (denom (d i)))
      (if (equal? i 1)
          (/ num (+ denom accumulator))
          (try n d (- i 1) k (/ num (+ denom accumulator))))))
  ;; Start with i = k and accumulator = 0.
  (try n d k k 0))


(define (euler-d i)
  (define (is-accumulator? x)
    (= 0 (remainder (- x 2) 3)))
  (if (is-accumulator? i)
      (* 2 (/ (+ i 1) 3))
      1))


(define (cont-frac-euler)
  (cont-frac (lambda (i) 1.0) (lambda (i) (euler-d i)) 20))


(define (is-main?)
  (let ((filename "ex1_38.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (display "e - 2 = ") (display (cont-frac-euler)) (newline))


(if (is-main?) (main))
