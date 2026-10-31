#!/usr/bin/guile -s
!#
;; Import the Time module.
(use-modules (srfi srfi-19))

;; Fibonacci is good to use as a prototypical case of tree recursion.
;; Each evluation of the procedure requires it to evaluate itself 2 times.
;;
;; This leads to large amounts of repetitions, is very inefficient.
(define (fibonacci n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fibonacci (- n 1))
                 (fibonacci (- n 2))))))


;; Iterative process for computing Fibonacci numbers.
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  
  (fib-iter 1 0 n))


(define (main)
  ;; Time the recursive fibonacci
  (define e1-t1 (current-time))
  (define fib-recursive (fibonacci 37))
  (define e1-t2 (current-time))
  (define e1-delta (/ (time-nanosecond (time-difference e1-t2 e1-t1)) 1000))

  ;; Time the iterative fibonacci
  (define e2-t1 (current-time))
  (define fib-iterative (fib 37))
  (define e2-t2 (current-time))
  (define e2-delta (/ (time-nanosecond (time-difference e2-t2 e2-t1)) 1000))

  ;; Output results
  (define e1-result-str (simple-format #f "Recursive fibonacci(37) time: ~A us" e1-delta))
  (define e2-result-str (simple-format #f "Iterative fibonacci(37) time: ~A us" e2-delta))
  (display e1-result-str) (newline)
  (display e2-result-str) (newline))


(main)
