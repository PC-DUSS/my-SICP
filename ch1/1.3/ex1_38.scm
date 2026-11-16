#!/usr/bin/guile -s
!#
;; TODO
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-15
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define (is-main?)
  (let ((filename "ex1_37.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  ;; TODO
  #t
  )


(if (is-main?) (main))

