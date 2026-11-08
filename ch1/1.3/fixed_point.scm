#!/usr/bin/guile -s
!#
;; Find a fixed point of a function. A fixed point is a point of a function
;; where f(x) = x.
;;
;; Algorithm:
;; Start with an initial guess, and keep reapplying function f to the output
;; until we get two successive values with a difference less than some
;; prescribed tolerance.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-07
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (fixed-point f guess)
  (define tolerance 0.00001)
  (define (close-enough? x y)
    (<= (abs (- y x)) tolerance))

  (let ((output (f guess)))
    (if (close-enough? output guess)
        guess
        (fixed-point f output))))


(define (sqrt x)
  ;; Could we try finding the square root of a number using the same fixed-point
  ;; method?
  ;;
  ;; Where y^2 = x, we can say y = x/y. There, f(y) = x/y. Find y = y/x to find
  ;; the square root of x.
  (fixed-point (lambda (y) (/ x y))
               1.0))


(define (main)
  (display (fixed-point cos 1.0))
  (newline)
  (display (fixed-point (lambda (y) (+ (sin y) (cos y)))
                        1.0))
  (newline)
  
  ;; Let's see if our 'sqrt' procedure works (hint: it doesn't).
  (display (sqrt 25))
  (newline)
  ;; TODO
  )


(if (or (equal? (car (command-line)) "fixed_point.scm")
        (equal? (car (command-line)) "./fixed_point.scm"))
    (main))


;; Illustrating why our current 'sqrt' procedure doesn't work with our
;; 'fixed-point' procedure:
;;
;; (sqrt 25)
;; => (fixed-point (lambda (y) (/ 25 y)) 1.0)
;; => (if (close-enough? 25.0 1.0) guess (fixed-point (lambda (y) (/ 25 y)) 25.0))
;; => (fixed-point (lambda (y) (/ 25 y)) 25.0)
;; => (if (close-enough? 1.0 25.0) guess (fixed-point (lambda (y) (/ 25 y)) 1.0))
;; => (fixed-point (lambda (y) (/ 25 y)) 1.0)
;;
;; We just recreated the exact same call to 'fixed-point' as the first call that
;; was done after calling (sqrt 25). This means that our 'sqrt' procedure will
;; never converge and will be stuck in an infinite recursion loop.

