#!/usr/bin/guile -s
!#
;; Modify 'fixed-point' so that it prints the sequence of approximations it
;; generates, using the 'newline' and 'display' primitives shown in exercise
;; 1.22. Then, find a solution to x^x = 1000 by finding a fixed point of:
;;   (x) -> log(1000)/log(x)
;;
;; (use Scheme's primitive 'log' procedure, which computes natural logarithms).
;; Compare the number of steps it takes with vs. without "average damping".
;; Note: you cannot start with an initial guess of 1 or 1.0, since log(1) = 0.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-15
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define tolerance 0.000001)

;; Global variables to count the number of iterations done in each variant of
;; the fixed-point procedure.
(define reg-iters 0)
(define avged-iters 0)


(define (average a b)
  (/ (+ a b) 2))


(define (inc x)
  (+ 1 x))


(define (fixed-point f guess)
  (define (close-enough? current previous)
    (< (abs (- current previous)) tolerance))
  (let ((next (f guess)))
    ;; Print each guess.
    (display next) (newline)
    ;; Increment the number of iterations done.
    (set! reg-iters (inc reg-iters))
    (if (close-enough? next guess)
        next
        (fixed-point f next))))


(define (fixed-point-avg f guess)
  ;; Fixed point, but with average damping.
  (define (close-enough? current previous)
    (< (abs (- current previous)) tolerance))
  (let ((next (average guess (f guess))))
    ;; Print each guess.
    (display next) (newline)
    ;; Increment the number of iterations done.
    (set! avged-iters (inc avged-iters))
    (if (close-enough? next guess)
        next
        (fixed-point-avg f next))))


(define (is-main?)
  (let ((filename "ex1_36.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (define result (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0))
  (display "Find x where x^x = 1000\nx = ")
  (display result)
  (newline)
  (display "Number of iterations: ") (display reg-iters)
  (newline)
  (newline)
  (define result-avged (fixed-point-avg (lambda (x) (/ (log 1000) (log x)))
                       2.0))
  (display "Find x where x^x = 1000, with average damping\nx = ")
  (display result-avged)
  (newline)
  (display "Number of iterations: ") (display avged-iters)
  (newline))


(if (is-main?) (main))

