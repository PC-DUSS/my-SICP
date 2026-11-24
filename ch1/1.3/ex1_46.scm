#!/usr/bin/guile -s
!#
;; We can abstract the algorithm we've been using to compute something by
;; improving our guesses until our current guess is good enough. This
;; abstraction is "iterative-improvement".
;;
;; Write a procedure 'iterative-improve' that takes two procedures as arguments:
;; a method for telling when the guess is good enough, and a method for
;; improving a guess. 'iterative-improve' should return as its value a procedure
;; that takes a guess as argument and keeps improving until the guess is good
;; enough.
;;
;; Then, rewrite the 'sqrt' procedure and the 'fixed-point' procedure as a function
;; of 'iterative-improve'.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-23
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define dx 0.00001)

(define (inc x) (+ x 1))

(define (square x) (* x x))

(define (even? x) (= 0 (remainder x 2)))

(define (average x1 x2) (/ (+ x1 x2) 2))

(define (pow b n)
  (define (iter b n adj-factor)
    (if (= n 1)
        (* b adj-factor)
        (if (even? n)
            (iter (square b) (/ n 2) adj-factor)
            (iter (square b) (/ (- n 1) 2) (* b adj-factor)))))
  (iter b n 1.0))

(define (iterative-improve good-enough? improve-guess)
  (define (try guess)
    (let ((next (improve-guess guess)))
      (if (good-enough? guess next)
          next
          (try next))))
  try)

(define (fixed-point f)
  (let ((tolerance 0.00001))
    ((iterative-improve (lambda (guess next) (< (abs (- next guess)) tolerance))
                       (lambda (guess) (f guess))) 1.0)))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (let ((tolerance 0.00001)
        (newtons-transform (lambda (y) (/ x y))))
    ((iterative-improve (lambda (guess next) (< (abs (- next guess)) tolerance))
                        (lambda (guess) ((average-damp newtons-transform) guess)))
     1.0)))

(define (simplified-sqrt x)
  ;; Here we could also just use our new version of 'fixed-point', instead of
  ;; rewriting the whole expression in terms of 'iterative-improve'.
  (fixed-point (average-damp (lambda (y) (/ x y)))))

(define (is-main?)
  (let ((filename "ex1_46.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))

(define (main)
  (display (sqrt 625)) (newline)
  (display (simplified-sqrt 625)) (newline)
  (exit 0))

(if (is-main?) (main))
