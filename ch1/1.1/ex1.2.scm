#!/usr/bin/guile -s
!#
(define (ex1.2)
  (define (calculate)
    (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
       (* 3 (- 6 2) (- 2 7))))
  (display (calculate)) (newline))

(ex1.2)
