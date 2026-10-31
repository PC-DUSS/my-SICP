#!/usr/bin/guile -s
!#
;; Use the smallest-divisor procedure to find the smallest divisor of each of
;; the following numbers: 199, 1999 and 19999.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-30
;;
;; Code:
(define (main)

  (define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (define (square x)
        (* x x))
      (define (divides? dividend divisor)
        (= (remainder dividend divisor) 0))
      (cond ((> (square test-divisor) n) n)
            ((divides? n test-divisor) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))

  (display (string-append "199: "
                          (number->string (smallest-divisor 199))
                          "\n"))
  (display (string-append "1999: "
                          (number->string (smallest-divisor 1999))
                          "\n"))
  (display (string-append "19999: "
                          (number->string (smallest-divisor 19999))
                          "\n")))


(main)
