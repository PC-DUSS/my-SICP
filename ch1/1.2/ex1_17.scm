#!/usr/bin/guile -s
!#
;; Devise an algorithm with logarithmic number of steps for performing integer
;; multiplication by way of successive addition.
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

  (define (fast-mult base factor)
    (cond ((= factor 0) 0)
          ((= factor 1) base)
          ((even? factor) (fast-mult (double base) (halve factor)))
          (else (+ base (fast-mult base (- factor 1))))))

  (display (fast-mult BASE FACTOR)) (newline))

(main)
