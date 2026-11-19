#!/usr/bin/guile -s
!#
;; Using procedures as return values and its applications. A.k.a., building
;; abstractions with higher-order procedures.
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

(define (fixed-point-with-transform f transform guess)
  ;; This is an abstraction of applying a transformation on a function in order
  ;; to calculate one of its fixed-points, rather than simply re-applying the
  ;; vanilla function on each new guess. We were doing this when we were passing
  ;; an average-damped version of a function or a Newton's method transformation
  ;; of our function to the 'fixed-point' procedure, rather than simply passing
  ;; the function itself (because in some cases simply reapplying the function
  ;; itself would never converge to a fixed-point).
  (fixed-point (transform f) guess))

(define (average-damp-sqrt-abstracted x)
  ;; Use our latest 'fixed-point-with-transform' abstraction to compute square
  ;; roots.
  ;;
  ;; f:
  ;; The equation that represents the relationship between the square root
  ;; and its square, but turn into a function for which to find a fixed-point.
  ;;
  ;; transform:
  ;; The procedure used to transform the vanilla application of the
  ;; square-root-equation-turned-into-function in order to help repeated
  ;; applications of this function converge to a fixed-point. In this case we
  ;; are using 'average-damp' to transform each application of the given
  ;; function by averaging its output with its input.
  ;;
  ;; guess:
  ;; The initial guess. Here we start with 1.0.
  (fixed-point-with-transform (lambda (y) (/ x y)) average-damp 1.0))

(define (newtons-method-sqrt-abstracted x)
  ;; Use our latest 'fixed-point-with-transform' abstraction to compute square
  ;; roots.
  ;;
  ;; f:
  ;; The equation for which finding a zero allows us to find a fixed-point to
  ;; the function which actually allows us to identify a square root (see
  ;; Newton's method of finding square roots for more details).
  ;;
  ;; transform:
  ;; The procedure used to transform the vanilla application of the
  ;; square-root-equation-turned-into-function in order to help repeated
  ;; applications of this function converge to a fixed-point. In this case we
  ;; are using 'newtons-transform' to compute each iteration as a function of
  ;; both the input and the output of the newton transformation (each successive
  ;; try is a function of the input and the output of the Newton's
  ;; transformation of the new guess, which is itself based on the output and
  ;; the input of the Newton transform of the previous guess, unless the
  ;; previous guess was the initial guess).
  ;;
  ;; guess:
  ;; The initial guess. Here we start with 1.0.
  (fixed-point-with-transform (lambda (y) (- (square y) x)) newton-transform 1.0))

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
  (letrec ((x 144)
           (msg (string-append "Abstracted average-damping square root of "
                               (number->string x)
                               " = "
                               (number->string (average-damp-sqrt-abstracted x))
                               "\n")))
    (display msg))
  (letrec ((x 121)
           (msg (string-append "Abstracted Newton's method square root of "
                               (number->string x)
                               " = "
                               (number->string
                                (newtons-method-sqrt-abstracted x))
                               "\n")))
    (display msg))
  (exit 0))

(define (is-main?)
  (let ((filename "procedures_as_return_values.scm")
        (loaded-file (car (command-line))))
    (or (equal? loaded-file filename)
        (equal? loaded-file (string-append "./" filename)))))

(if (is-main?) (main))
