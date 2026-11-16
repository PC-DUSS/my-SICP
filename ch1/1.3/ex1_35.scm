#!/usr/bin/guile -s
!#
;; Show that the golden ratio (Section 1.2.2) is a fixed point to the
;; transformation  (x) -> 1 + 1/x  , and use this fact to compute the golden
;; ratio using our 'fixed-point' procedure.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-15
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define tolerance 0.0001)


(define (average a b)
  (/ (+ a b) 2))


(define (fixed-point f guess)
  (define (close-enough? current previous)
    (< (abs (- current previous)) tolerance))
  (let ((next (f guess)))
    (if (close-enough? next guess)
        next
        (fixed-point f next))))


(define (fixed-point-avg f guess)
  (define (close-enough? current previous)
    (< (abs (- current previous)) tolerance))
  (let ((next (average guess (f guess))))
    (if (close-enough? next guess)
        next
        (fixed-point f next))))


(define (is-main?)
  (let ((filename "ex1_35.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  (define result (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
  (display "golden ratio = ") (display result) (newline))


(if (is-main?) (main))

