#!/usr/bin/guile -s
!#
;; Example results:
;;
;; n: 3 => 2 + 2(1) + 3(0) = 4
;; n: 4 => 4 + 2(2) + 3(1) = 11
;; n: 5 => 11 + 2(4) + 3(2) = 25
;; n: 6 => 25 + 2(11) + 3(4) = 59
;; n: 7 => 59 + 2(25) + 3(11) = 142
;; n: 8 => 142 + 2(59) + 3(25) = 335
(define NUMBER 33)


(define (recursive-f n)
  (define (f n)
    (if (< n 3)
        n
        (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))
  (f n))


(define (iterative-f n)
  (define (f count a b c)
    (cond ((< count 3) count)
          ((= count 3) (+ a (* 2 b) (* 3 c)))
          (else (f (- count 1) (+ a (* 2 b) (* 3 c)) a b))))
  (f n 2 1 0))


(define (run-recurs)
  (define recurse-t1 (get-internal-run-time))
  (define recurse-result (recursive-f NUMBER))
  (define recurse-t2 (get-internal-run-time))
  (define recurse-timedelta (- recurse-t2 recurse-t1))
  (define recurse-result-string (string-append
                                 "Recursive: f(" (number->string NUMBER) ") = "
                                 (number->string recurse-result) " Time = "
                                 (number->string (/ recurse-timedelta 1000.0))
                                 " microseconds"))
  (display recurse-result-string) (newline))


(define (run-iter)
  (define iterate-t1 (get-internal-run-time))
  (define iterate-result (iterative-f NUMBER))
  (define iterate-t2 (get-internal-run-time))
  (define iterate-timedelta (- iterate-t2 iterate-t1))
  (define iterate-result-string (string-append
                                 "Iterative: f(" (number->string NUMBER) ") = "
                                 (number->string iterate-result) " Time = "
                                 (number->string (/ iterate-timedelta 1000.0))
                                 " microseconds"))
  (display iterate-result-string) (newline))


(define (main)
  (run-recurs)
  (run-iter))


(main)
