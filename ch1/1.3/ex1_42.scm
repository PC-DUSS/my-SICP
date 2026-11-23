#!/usr/bin/guile -s
!#
;; Deﬁne a procedure compose that implements composition, accepting two
;; functions f(x) and g(x), and returning the composed function f(g(x)).
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-19
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (inc x) (+ x 1))


(define (square x) (* x x))


(define (double f)
  (lambda (x) (f (f x))))


(define (compose f g)
  (lambda (x) (f (g x))))


(define (is-main?)
  (let ((filename "ex1_42.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (display ((compose square inc) 6))
  (newline)
  (exit 0))


(if (is-main?) (main))

