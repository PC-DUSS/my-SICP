#!/usr/bin/guile -s
!#
;; Define a procedure 'double' that takes a procedure of one argument as
;; argument and returns a procedure that applies the original procedure
;; twice. E.g. as in f(f(x)).
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-19
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (double f)
  (lambda (x) (f (f x))))


(define (inc x) (+ x 1))


(define (is-main?)
  (let ((filename "ex1_41.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  ;; We can represent the application of the function to itself as squaring the
  ;; function. We can represent squaring the squaring of the function as
  ;; tetration of the function. f^2^n. Here, n=3, which means f^2^2^2 = f^16.
  ;; This means 'inc' will be applied 16 times. 1 time over the initial input,
  ;; and 15 times over its own previous output. Since 'inc' is simply addition
  ;; by 1, this results in:
  ;;   (+ 1 (+ 1 (+ 1 (+ 1 ( + 1 ( + 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 5))))))))))))))))
  ;; which results in 21.
  (display (((double (double double)) inc) 5))
  (newline)
  (exit 0))


(if (is-main?) (main))

