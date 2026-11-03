#!/usr/bin/guile -s
!#
;; a) Extract the "Accumulator" abstraction from the previous sum and product
;;    procedures (ex1.29 to ex1.31). Write an 'accumulate' procedure, and show
;;    how sum and product can both be achieved using this more general
;;    procedure.
;;
;; b) If your 'accumulate' procedure generates a recursive process, write a
;;    different one that generates an iterative process. If it generates an
;;    iterative process, write a different one that generates a recursive
;;    process.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-02
;;
;; Copyright 2026 Pierre C. Dussault. See the LICENSE file for details.
;;
;; Code:
(define (identity x) x)


(define (inc x) (+ x 1))


(define (accumulate-recursive combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-recursive combiner
                                               null-value
                                               term
                                               (next a)
                                               next
                                               b))))


(define (accumulate-iterative combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


(define (sum-recursive term a next b)
  (accumulate-recursive + 0 term a next b))


(define (sum-iterative term a next b)
  (accumulate-iterative + 0 term a next b))


(define (product-recursive factor a next b)
  (accumulate-recursive * 1 factor a next b))


(define (product-iterative factor a next b)
  (accumulate-iterative * 1 factor a next b))


(define (main)
  (display "sum-recursive[1-6] = ")
  (display (sum-recursive identity 1 inc 6))
  (newline)

  (display "product-recursive[1-6] = ")
  (display (product-recursive identity 1 inc 6))
  (newline)

  (display "sum-iterative[1-6] = ")
  (display (sum-iterative identity 1 inc 6))
  (newline)

  (display "product-iterative[1-6] = ")
  (display (product-iterative identity 1 inc 6))
  (newline))


(main)


