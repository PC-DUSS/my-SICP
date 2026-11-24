#!/usr/bin/guile -s
!#
;; We saw that average-damping enabled us to find fixed-points of square root
;; and cube root functions, with (y) -> x/y and (y) -> x/y^2 respectively.
;; Unfortunately, this trick is not sufficient to make fourth roots converge
;; with (y)- > x/y^3. However, we can make it converge if we use the
;; average-damp of the average-damp (average-damp twice).
;;
;; Do some experiments to determine how many times average-damp must be applied
;; in order to converge to a fixed-point of any n'th root based on the average
;; damping of (y) -> x/y^(n-1).
;;
;; Use that to write a procedure that computes n'th roots using 'fixed-point',
;; 'average-damp' and 'repeated' from ex1.43.
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

(define (fixed-point f)
  ;; FIXME
  (define tolerance 0.00001)
  (define (find-fixed-point f guess)
    (let ((next (f guess)))
      (if (< (abs (- next guess)) tolerance)
          next
          (find-fixed-point f next))))
  (find-fixed-point f 1.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))))

(define (double f)
  (lambda (x) (f (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x) ((compose (repeated f (- n 1)) f) x))))

(define (smooth f)
  (define (3-avg y1 y2 y3)
    (/ (+ y1 y2 y3) 3))
  (lambda (x) (3-avg (f (- x dx))
                     (f x)
                     (f (+ x dx)))))

(define (n-smooth f n)
  ((repeated smooth n) f))

(define (fourth-root x)
  (fixed-point ((double average-damp) (lambda (y) (/ x (pow y 3))))))

(define (fifth-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (pow y 4))))))

(define (sixth-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (pow y 5))))))

(define (seventh-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (pow y 6))))))

(define (eighth-root x)
  (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (pow y 7))))))

(define (fifteenth-root x)
  ;; This should work
  (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (pow y 14))))))

(define (sixteenth-root x)
  ;; But then here we would need to increment by one the number of times average-damp is applied.
  (fixed-point ((repeated average-damp 4) (lambda (y) (/ x (pow y 15))))))

(define (fail-sixteenth-root x)
  ;; This should fail. Hint: it fails as expected!
  (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (pow y 15))))))

(define (log-b base x)
  ;; This is the logarithm change of base formula.
  (/ (log x) (log base)))

(define (nth-root n x)
  ;; Is it log2(n-of-root)? Yes!
  (let ((num-repeats (floor (log-b 2 n))))
    (fixed-point ((repeated average-damp num-repeats)
                  (lambda (y) (/ x (pow y (- n 1))))))))

(define (is-main?)
  (let ((filename "ex1_45.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))

(define (main)
  (display (fifteenth-root 32768)) (newline)
  (display (sixteenth-root 65536)) (newline)
  ;;(display (fail-sixteenth-root 65536)) (newline)  ;; this fails.
  (display (nth-root 16 65536)) (newline)
  (display (nth-root 7 2187)) (newline)
  (display (nth-root 32 4294967296)) (newline)
  (exit 0))

(if (is-main?) (main))
