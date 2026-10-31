#!/usr/bin/guile -s
!#
;; Program to showcase recursion with a form of insertion sort.
;;
;; Author: Pierre C. Dussault
;; Date : 2026-02-19
;;
;; Copyright 2026 Pierre C. Dussault. All rights reserved.
(define (sort sent)
  (if (null? sent)
      '()
      (insert (car sent) (sort (cdr sent)))))

(define (insert num sent)
  (cond ((null? sent) (list num))
        ((< num (car sent)) (list num sent))
        (else (list (car sent) (insert num (cdr sent))))))

display (sort '(7 6 100 5))) (newline)
