#!/usr/bin/guile -s
!#
;; Find a fixed point of a function. A fixed point is a point of a function
;; where f(x) = x.
;;
;; Algorithm:
;; Start with an initial guess, and keep reapplying function f to its previous
;; output until we get two successive values with a difference less than some
;; prescribed tolerance.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-07
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (fixed-point f guess)
  (define tolerance 0.00001)
  (define (close-enough? x y)
    (< (abs (- y x)) tolerance))

  (let ((output (f guess)))
    (if (close-enough? output guess)
        guess
        (fixed-point f output))))


(define (sqrt x)
  ;; Could we try finding the square root of a number using the same fixed-point
  ;; method?
  ;;
  ;; Where y^2 = x, we can say y = x/y. There, f(y) = x/y. Find y = y/x to find
  ;; the square root of x.
  (fixed-point (lambda (y) (/ x y)) 1.0)
  ;; Unfortunately, this implementation never converges towards a result, it
  ;; generates an infinite iterative process.
  ;; Demonstration:
  ;;   y2 = x / y1
  ;;   y3 = x / y2 = x / (x / y1) = y1
  ;;   
  ;;   Since y3 = y1, we have now returned to our starting guess. This will keep
  ;;   happening on every other iteration.
  )


(define (square-root n)
  ;; Let's improve our square root algorithm. We know that the final answer
  ;; will reside between the current guess and (n / guess) (try out the
  ;; algorithm on a piece of paper to see that this is true). Perhaps we can
  ;; generate each new guess by averaging our current guess with (n / guess).
  ;; This should get us to the real answer faster, and avoid the infinite
  ;; looping problem.
  ;;
  ;; This technique of averaging previous guesses in order to find a new guess
  ;; is often useful for finding fixed-points and is called "average damping".
  ;;
  ;; Note that the equation for finding each new guess by averaging,
  ;; y = 1/2 * (y + x/y), is actually a just a transformation of the initial
  ;; equation y = x/y. To go from the initial equation to the averaging
  ;; equation, you just add y to each side, and then divide each side by 2.
  (define (average a b) (/ (+ a b) 2))
  (fixed-point (lambda (guess) (average guess (/ n guess))) 1.0))


(define (is-main?)
  (define filename "fixed_point.scm")
  (define cli-first-arg (car (command-line)))
  (or (equal? cli-first-arg filename)
      (equal? cli-first-arg (string-append "./" filename))))


(define (main)
  (display (fixed-point cos 1.0))
  (newline)
  (display (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0))
  (newline)
  
  ;; To show that our square root implementation doesn't converge (produces an
  ;; infinite iterative process).
  ;;(display (sqrt 25))
  
  ;; Let's try our new implementation of square root which uses averaging for
  ;; each new guess.
  (display "sqrt of 25 = ") (display (square-root 25))  ;; it works!
  (newline))


(if (is-main?) (main))


;; Illustrating why our current 'sqrt' procedure doesn't work with our
;; 'fixed-point' procedure:
;;
;; (sqrt 25)
;; => (fixed-point (lambda (y) (/ 25 y)) 1.0)
;; => (if (close-enough? 25.0 1.0) guess (fixed-point (lambda (y) (/ 25 y)) 25.0))
;; => (fixed-point (lambda (y) (/ 25 y)) 25.0)
;; => (if (close-enough? 1.0 25.0) guess (fixed-point (lambda (y) (/ 25 y)) 1.0))
;; => (fixed-point (lambda (y) (/ 25 y)) 1.0)
;;
;; We just recreated the exact same call to 'fixed-point' as the first call that
;; was done after calling (sqrt 25). This means that our 'sqrt' procedure will
;; never converge and will be stuck in an infinite recursion loop.

