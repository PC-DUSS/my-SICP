#!/usr/bin/guile -s
!#
;; Author: Pierre C. Dussault
;; Date: 2026-11-07
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (square x) (* x x))


(define (f g) (g 2))


(define (main)
  (display (f square)) (newline)
  (display (f (lambda (z) (* z (+ z 1))))) (newline)
  ;; What happens if we (perversely) ask the interpreter to evaluate the
  ;; combination (f f)? Explain.
  ;;
  ;; Answer: It attempts to execute (2 2), which is not a valid procedure.
  ;;
  ;; Explanation: Here is the trace of calls that would be triggered:
  ;; 1) (f f)
  ;; 2) (f 2)
  ;; 3) (2 2)
  ;;
  ;; Let's try it out and see if this is the case:
  (display (f f)) (newline)
  ;; Correct! It says "Incorrect type to apply: 2". It tries to apply '2' to
  ;; the argument passed (which is also '2'), but it complains that '2' is not
  ;; of a type than can be used for 'apply'. 'apply' applies a procedure to
  ;; subsequent elements. '2' is an integer, and cannot be applied as a
  ;; procedure.
  )


(main)

