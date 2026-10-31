#!/usr/bin/guile -s
!#
(define (ex1.3)
  (define (sum-of-squares-of-two-largest a b c)
    (define (two-largest m n o)
      (if (> m n)
          (if (> n o) (cons m n) (cons m o))
          (if (> m o) (cons n m) (cons n o))))
    (define (square x)
      (* x x))
    (+ (square (car (two-largest a b c)))
       (square (cdr (two-largest a b c)))))
  (display (sum-of-squares-of-two-largest 5 2 10)) (newline))

(ex1.3)
