#!/usr/bin/guile -s
!#
;; a) Take the generalized sum procedure, and convert it to a product procedure.
;;    Then, use this product procedure to approximate pi/4 using the following
;;    equation: pi/4 = 2/3 * 4/3 * 4/5 * 6/5 * 6/7 * 8/7 * 8/9 ...
;;
;; b) If your initial product procedure generates a recursive process, write a
;;    version that generates an iterative process, and if your initial procedure
;;    generates an iterative process, write a version that generates a recursive
;;    process.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-02
;;
;; Copyright 2026 Pierre C. Dussault. See the LICENSE file for details.
;;
;; Code:
(define (inc x) (+ x 1))


(define (even? x)
  (= (remainder x 2) 0))


(define (product-recursive factor a next b)
  (if (> a b)
      1
      (* (factor a) (product-recursive factor (next a) next b))))


(define (product-iterative factor a next b)
  (define (product-iter a result)
    ;; Here again, we are using the concept of a closure. The procedure does not
    ;; need to have parameters for all of its required variables, since it can
    ;; access the variables in the scope of the parent procedure. We don't break
    ;; encapsulation because this procedure only exists within its parent
    ;; procedure, so this usage of outer-scop variables will not have any side
    ;; effects on the broader program. Note how 'factor', 'next' and 'b' are
    ;; accessible even though they are not included as parameters in the
    ;; procedure's signature.
    ;;
    ;; At this point, SICP still has not introduced the concept of closures,
    ;; even though ex1.29, 1.30 and 1.31 require their use. The reader needs to
    ;; do research on their own, or somehow already know what are and how to use
    ;; closures in order to successfully complete these exercises. Hopefully the
    ;; book will soon formally introduce them.
    (if (> a b)
        result
        (product-iter factor (next a) next b (* result (factor a)))))
  (product-iter a 1))


(define (pi-fourth-recursive n)
  (define (factor a)
    (if (even? a)
        (/ (+ a 2) (+ a 3))
        (/ (+ a 3) (+ a 2))))
  (product-recursive factor 0.0 inc n))


(define (pi-fourth-iterative n)
  (define (factor a)
    (if (even? a)
        (/ (+ a 2) (+ a 3))
        (/ (+ a 3) (+ a 2))))  
  (product-iterative factor 0.0 inc n))


(define (pi-recursive n)
  (* 4 (pi-fourth-recursive n)))


(define (pi-iterative n)
  (* 4 (pi-fourth-iterative n)))


(define (main)
  (display "pi-recursive = ") (display (pi-recursive 50000)) (newline)
  (display "pi-iterative = ") (display (pi-iterative 50000)) (newline))


(main)


