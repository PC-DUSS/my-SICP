;; Write a procedure that smoothes a function by averaging f(x - dx), f(x) and
;; f(x + dx), where dx is a tiny value of delta-x. The procedure takes as input
;; a procedure that computes f and returns a procedure that computes smoothed f.
;; Also, since it is sometimes valuable to repeatedly smooth a function (smooth
;; the smoothed function, and so on), write a procedure that returns an a
;; procedure that computes the n-fold smoothed function f. Use 'repeated' from
;; the previous exercise.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-22
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define dx 0.00001)

(define (inc x) (+ x 1))

(define (square x) (* x x))

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

(define (is-main?)
  (let ((filename "ex1_44.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))

(define (main)
  (define (polynomial x)
    (+ (* -2 (square x)) (* 3 x) 2))
  (display "Polynomial: y = -2x^2 + 3x + 2") (newline)
  (display "Raw = ") (display (polynomial 1000)) (newline)
  (display "Smoothed = ") (display ((smooth polynomial) 1000)) (newline)
  (display "10x-Smoothed = ") (display ((n-smooth polynomial 10) 1000)) (newline)
  (exit 0))

(if (is-main?) (main))
