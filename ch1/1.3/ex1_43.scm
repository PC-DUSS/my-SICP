;; Write a procedure that takes as inputs a procedure that computes f and a
;; positive integer n and returns the procedure that computes the n'th repeated
;; application of f. Use the 'compose' procedure from the previous exercise.
;;
;; This is a generalization of the idea of tetration of a function. Meaning,
;; the function applied to itself, n-number of times, in the form of f^n(x).
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

(define (repeated f n)
  ;; Using 'compose'.
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x) ((compose (repeated f (- n 1)) f) x))))


(define (repeated-custom f n)
  ;; Not using 'compose'.
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x) ((repeated f (- n 1)) (f x)))))


(define (is-main?)
  (let ((filename "ex1_43.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (display ((repeated square 2) 5))
  (newline)
  (display ((repeated-custom square 2) 5))
  (newline)
  (exit 0))


(if (is-main?) (main))
