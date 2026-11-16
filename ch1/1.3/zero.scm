#!/usr/bin/guile -s
!#
;; Find a zero of a function, given points 'a' and 'b', where f(a) < 0 and
;; f(b) > 0, implying that there is some point 'x' between 'a' and 'b' where
;; f(x) crosses the x-axis and thus, is a zero.
;;
;; Algorithm:
;; Let 'x' be the average of 'a' and 'b'. If f(x) > 0, then the zero
;; occurs between 'a' and the current 'x'. Set 'x' to the average of 'x' and
;; 'a'. If f(x) < 0, then the zero occurs between the current 'x' and 'b'. Set
;; 'x' to the average of 'b' and 'x'. Keep doing this until f(x) is equal to 0,
;; or close enough to be considered a zero (you can tweak the acceptable margin
;; of error as desired).
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-07
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define tolerance 0.0001)


(define (average x y) (/ (+ x y) 2))


(define (cube x) (* x x x))


(define (close-enough? point1 point2)
  (<= (abs (- point2 point1)) tolerance))


(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value) 
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))


(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value)) (search f a b))
          ((and (negative? b-value) (positive? a-value)) (search f b a))
          (else (error "Values are not of opposite sign" a b)))))


(define (example-find-pi-zero)
  ;; Finding the zero of the sin function, between 2.0 radians and 4.0 radians
  ;; should give us PI (think of the trigonometric unit circle). The sin
  ;; function has two zeroes, one at 0 radians and the other at pi radians.
  ;; Note: sin is a built-in function in the Scheme spec.
  (display (half-interval-method sin 2.0 4.0))
  (newline))


(define (example-find-zero-of-equation)
  ;; Find a zero for x^3 - 2x - 3, from x = 1 through x = 2.
  ;; Let's use a lambda expression to pass this function to our
  ;; half-interval-method procedure.
  (display (half-interval-method (lambda (x) (- (cube x) (* 2 x) 3)) 1.0 2.0))
  (newline))


(define (is-main?)
  (let ((filename "zero.scm") (loaded-file (car (command-line))))
    (or (equal? filename loaded-file)
        (equal? filename (string-append "./" loaded-file)))))


(define (main)
  (example-find-pi-zero)
  (example-find-zero-of-equation)
  )


(if (is-main?) (main))

