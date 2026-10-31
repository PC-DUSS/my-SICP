#!/usr/bin/guile -s
!#
;; A look at the different methods to do exponentiation, and the process that
;; each method generates.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-27
;;
;; Code:
(define (main)
  ;; Constants
  (define EXP-BASE 5)
  (define EXP-PWR 5)

  ;; This should produce a linear recursive process. Time complexity = O(n),
  ;; space complexity O(n).
  (define (expt-a b n)
    (if (= n 0)
        1
        (* b (expt-a b (- n 1)))))

  ;; Just like with factorial, we can produce an iterative process to accomplish
  ;; the same task. This one requires the same amount of steps
  ;; (time complexity = O(n)), but only requires constant space
  ;; (space complexity = O(1)) since it stores the accumulated result in an
  ;; accumulator variable that is passed on in each new recursive call (the
  ;; 'product' variable).
  (define (expt-b b n)
    (define (expt-iter b n product)
      (if (= n 0)
          product
          (expt-iter b (- n 1) (* b product))))
    (expt-iter b n 1))

  ;; Helper functions 
  (define (even? x)
    (if (= (remainder x 2) 0)
        #t
        #f))
  (define (sqr x)
    (* x x))
  
  ;; Here is the successive squaring method. This should produce a logarithmic
  ;; process. Time complexity = O(log(n)), space complexity = O(log(n)).
  (define (expt-c b n)
    (cond ((= n 0) 1)
          ((even? n) (* (expt-c b (/ n 2)) (expt-c b (/ n 2))))
          (else (* b (expt-c b (- n 1))))))

  ;; Ex1.16: now for a small challenge, let's try to formulate an iterative process
  ;; version of the successive squaring method. We'll combine what we did to go
  ;; from the linear recursive to the linear iterative process version earlier.
  ;; This new version will have Time complexity = O(log(n)), but
  ;; Space complexity = O(1).
  (define (expt-d b n)
    (define (expt-iter b n product)
      (cond ((= n 0) product)
            ((even? n) (expt-iter b (/ n 2) (sqr product)))
            (else (expt-iter b (- n 1) (* b product)))))
    (expt-iter b n 1))

  (display (expt-a EXP-BASE EXP-PWR)) (newline)
  (display (expt-b EXP-BASE EXP-PWR)) (newline)
  (display (expt-c EXP-BASE EXP-PWR)) (newline)
  (display (expt-d EXP-BASE EXP-PWR)) (newline))


(main)
