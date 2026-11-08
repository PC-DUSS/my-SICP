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
(define ERR-MARGIN 0.001)


(define (average x y) (/ (+ x y) 2))


(define (close-enough? point1 point2)
  (<= (abs (- point2 point1)) ERR-MARGIN))


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


(define (main)
  (display (half-interval-method sin 2.0 4.0)) (newline)
  )


(if (or (equal? (car (command-line)) "zero.scm")
        (equal? (car (command-line)) "./zero.scm"))
    (main))

