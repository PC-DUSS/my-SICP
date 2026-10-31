#!/usr/bin/guile -s
!#
;; Devise an algorithm for computing Fibonacci numbers, but in a logarithmic,
;; instead of exponential, number of steps.
;;
;; Exercise 1.19: ere is a clever algorithm for computing
;; the Fibonacci numbers in a logarithmic number of steps.
;; Recall the transformation of the state variables a and b in
;; the fib-iter process of Section 1.2.2: a ← a +b and b ← a.
;; Call this transformation T , and observe that applying T
;; over and over again n times, starting with 1 and 0, produces
;; the pair Fib(n + 1) and Fib(n). In other words, the Fibonacci
;; numbers are produced by applying T n , the n th power of the
;; transformation T , starting with the pair (1, 0). Now consider
;; T to be the special case of p = 0 and q = 1 in a family of
;; transformations Tpq , where Tpq transforms the pair (a, b)
;; according to a ← bq + aq + ap and b ← bp + aq. Show
;; that if we apply such a transformation Tpq twice, the eﬀect
;; is the same as using a single transformation Tp ′q ′ of the
;; same form, and compute p ′ and q ′ in terms of p and q. is
;; gives us an explicit way to square these transformations,
;; and thus we can compute T n using successive squaring, as
;; in the fast-expt procedure. Put this all together to com-
;; plete the following procedure, which runs in a logarithmic
;; number of steps:
;;
;; (define (fib n)
;;   (fib-iter 1 0 0 1 n))
;; (define (fib-iter a b p q count)
;;   (cond ((= count 0) b)
;;         ((even? count)
;;            (fib-iter a
;;            b
;;            ⟨??⟩  ;; compute p'
;;            ⟨??⟩  ;; compute q'
;;            (/ count 2)))
;;         (else (fib-iter (+ (* b q) (* a q) (* a p))
;;                         (+ (* b p) (* a q))
;;                         p
;;                         q
;;                         (- count 1)))))
;;
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-28
;;
;; Code:
(define (main)
  (define NUM 18)
  (define (even? x)
    (if (= (remainder x 2) 0)
        #t
        #f))
  (define (fib n)
    (define (fib-iter a b q p count)
      (cond ((= count 0) b)
            ((even? count) (fib-iter a
                                     b
                                     (+ (* p q) (* q q) (* q p))
                                     (+ (* p p) (* q q))
                                     (/ count 2)))
            (else (fib-iter (+ (* b q) (* a q) (* a p))
                            (+ (* b p) (* a q))
                            q
                            p
                            (- count 1)))))
    (fib-iter 1 0 1 0 n))
  (display (fib NUM)) (newline))
  
  (main)
