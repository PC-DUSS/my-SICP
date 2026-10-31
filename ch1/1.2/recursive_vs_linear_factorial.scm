#!/usr/bin/guile -s
!#
(define (rec-fact n)
  ;; Recursive factorial.
  (if (= n 0)
      1
      (* n (rec-fact (- n 1)))))


(define (iter-fact n)
  ;; Iterative factorial.
  (define (iter counter product n)
    (if (> counter n)
        product
        (iter (+ counter 1) (* product counter) n)))

  (iter 1 1 n))


(simple-format #t "~S\n" (rec-fact 6))
(simple-format #t "~S\n" (iter-fact 6))
