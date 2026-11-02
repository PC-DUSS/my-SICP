#!/usr/bin/guile -s
!#
;; Show that the Carmichael numbers really do fool the Fermat test.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-31
;;
;; Code:
(define (main)

  (define (displayln str)
    (display (string-append str "\n")))

  (define (even? x)
    (= (remainder x 2) 0))

  (define (square x)
    (* x x))

  (define (expmod base n mod)
    (cond ((= n 0) 1)
          ((even? n) (remainder (square (expmod base (/ n 2) mod)) mod))
          (else (remainder (* base (expmod base (- n 1) mod)) mod))))

  (define (fermat-test n a)
    (cond ((> a (- n 1)) #t)
          ((= (expmod a n n) a)
            (if (= a 2)
                (fermat-test n 3)
                (fermat-test n (+ a 2))))
          (else #f)))

  (define (fast-prime? n)
    (fermat-test n 2))

  (define (run-test lst)
    (for-each (lambda (n)
                (display n)
                (define is-prime-flag (fast-prime? n))
                (display ": ")
                (if is-prime-flag (display "pass\n") (display "FAIL\n")))
              lst))

  ;; Carmichael numbers taken from footnote-47 on page 69.
  (define carmichael-numbers '(561 1105 1729 2465 2821 6601))

  (display "Checking if these Carmichael numbers can fool the Fermat test:\n")
  (run-test carmichael-numbers))


(main)

