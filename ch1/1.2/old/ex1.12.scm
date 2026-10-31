#!/usr/bin/guile -s
!#
;; Algorithm for generating a value from the Pascal Triangle, from a given row
;; and column position. Also comes with an example that generates the Pascal
;; Triangle up to the given row number.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-26
;;
;; Copyright 2026 Pierre C. Dussault. All rights reserved.
;;
;; Code:
(define (main)
  (define (pascal-value row col)
    (if (or (= 0 col) (= col row))
        1
        (+ (pascal-value (- row 1) (- col 1))
           (pascal-value (- row 1) col))))

  (define (pascal-triangle size)
    (define (pascal row col)
      (if (= col (- size 1))
          (begin
            (display "1\n")
            0)
          (if (= col row)
              (begin
                (display "1\n")
                (pascal (+ row 1) 0))
              (begin
                (display (string-append (number->string (pascal-value row col)) " "))
                (pascal row (+ col 1))))))

    (pascal 0 0))

  (define (validate-usage)
    (define (too-many-args-error)
      (display (string-append "ex1_12.scm: Incorrect usage. Too many arguments."
                              " ex1_12.scm accepts a single integer number as "
                              "an argument.\n"))
      (exit 1))

    (define (missing-args-error)
      (display (string-append "ex1_12.scm: Incorrect usage. Missing arguments."
                              " ex1_12.scm accepts a single integer number as "
                              "an argument.\n"))
      (exit 1))

    (define (wrong-type-args-error)
      (display (string-append "ex1_12.scm: Incorrect usage. Arguments have the"
                              " wrong type. ex1_12.scm accepts a single "
                              "integer number as an argument.\n"))
      (exit 1))

    (if (> (length (command-line)) 2)
        (too-many-args-error)
        (if (< (length (command-line)) 2)
            (missing-args-error)
            (if (integer? (string->number (list-ref (command-line) 1)))
                #t
                (wrong-type-args-error)))))

  (if (validate-usage)
      (pascal-triangle (string->number (list-ref (command-line) 1)))
      1))


(main)
