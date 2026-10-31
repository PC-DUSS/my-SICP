#!/usr/bin/guile -s
!#
;; Calculating the sine of an angle using a recursive process.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-27
;;
;; Code:
(define (main)
  (define (cube x)
    (* x x x))

  (define (abs x)
    (if (> x 0)
        x
        (- x)))

  (define (p x)
    (- (* 3 x) (* 4 (cube x))))

  (define (sine angle)
    (if (< (abs angle) 0.1)
        angle
        (p (/ x 3.0))))

  ;; TODO
  )

;; a) If angle = 12.15 radians, procedure p will be applied 5 times.
;; b) Time complexity = O(log(n)). Space complexity = O(log(n)).
