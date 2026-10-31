#!/usr/bin/guile -s
!#
;; Devise an algorithm with logarithmic number of steps for performing integer
;; multiplication by way of successive addition, but make it iterative
;; (constant space instead of logarithmic space).
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-28
;;
;; Code:
(define (main)
  (define BASE 5)
  (define FACTOR 21)
  
  (define (even? x)
    (if (= (remainder x 2) 0)
        #t 
        #f))
  
  (define (double x)
    (* 2 x))
  
  (define (halve x)
    (/ x 2))

  (define (fast-mult-iter base factor)
    (define (iter base factor offset)
      (cond ((= factor 0) 0)
            ((= factor 1) (+ base offset))
            ((even? factor) (iter (double base) (halve factor) offset))
            (else (iter base (- factor 1) (+ offset base)))))
    (iter base factor 0))

  (display (fast-mult-iter BASE FACTOR)) (newline))

(main)
