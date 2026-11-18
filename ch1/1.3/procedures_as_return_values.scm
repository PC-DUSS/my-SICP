#!/usr/bin/guile -s
!#
;; Procedures as return values and their applications.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-18
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (square x) (* x x))

(define (cube x) (* x x x))

(define (average x1 x2)
  (/ (+ x1 x2) 2))

(define (fixed-point f guess)
  ;; 'f' is the procedure to apply to 'guess' in order to generate each new
  ;; guess.
  (define tolerance 0.0001)
  (let ((next (f guess)))
    (if (< (abs (- next guess)) tolerance)
        next
        (fixed-point f next))))

(define (average-damp f)
  (lambda (y) (average y (f y))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (cube-root x)
  ;; A slight modification to the function used to generate each new guess from
  ;; the 'sqrt' procedure enables us to compute a cube-root.
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

(define (deriv f)
  ;; Compute the derivative of a function.
  (let ((dx 0.00001))
    (lambda (x) (/ (- (f (+ x dx)) (f x)) dx))))

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  ;; Newton's method, using our 'fixed-point' procedure to converge on a value
  ;; and our 'newton-transform' procedure to generate each new guess.
  ;;
  ;; This is an alternative method to average-damp which can be used when the
  ;; function for which we are searching for a fixed point is differentiable.
  (fixed-point (newton-transform g) guess))

(define (newton-sqrt x)
  ;; Calculate square root using Newton's method.
  (newtons-method (lambda (y) (- (square y) x)) 1.0))

(define (main)
  (letrec ((x 25)
           (msg (string-append "Square root of "
                               (number->string x)
                               " = "
                               (number->string (sqrt x))
                               "\n")))
    (display msg))
  (letrec ((x 27)
           (msg (string-append "Cube root of "
                               (number->string x)
                               " = "
                               (number->string (cube-root x))
                               "\n")))
    (display msg))
  (letrec ((x 5)
           (msg (string-append "For f(x)=x^3 when x = "
                               (number->string x)
                               ", Df(5) = "
                               (number->string ((deriv cube) x))
                               "\n")))
    (display msg))
  (letrec ((x 81)
           (msg (string-append "Newton's method square root of "
                               (number->string x)
                               " = "
                               (number->string (newton-sqrt x))
                               "\n")))
    (display msg))
  (exit 0))

(define (is-main?)
  (let ((filename "procedures_as_return_values.scm")
        (loaded-file (car (command-line))))
    (or (equal? loaded-file filename)
        (equal? loaded-file (string-append "./" filename)))))

(if (is-main?) (main))
