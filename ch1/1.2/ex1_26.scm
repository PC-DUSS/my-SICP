;; Louis Reasoner says that his 'fast-prime?' version is running more slowly
;; than his 'prime?' version. His implementation of 'expmod' seems to be the
;; culprit. Why? Louis Reasoner's implementation is showcased in 'slow-expmod',
;; while the correct implementation is shown in 'fast-expmod'. Explain why Louis
;; Reasoner's implementation is causing him performance problems.
;;
;; View "./ex1_26_explanation.pdf" and "./ex1_26.png" for the answer.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-31
(define (fast-expmod base power mod)
  (cond ((= power 0) 1)
        ((even? power) (remainder (square (fast-expmod base (/ power 2) mod))
                                  mod))
        (else (remainder (* base (fast-expmod base (- power 1) mod)) mod))))

(define (slow-expmod base power mod)
  (cond ((= power 0) 1)
        ((even? power) (remainder (* (slow-expmod base (/ power 2) mod)
                                     (slow-expmod base (/ power 2) mod))
                                  mod))
        (else (remainder (* base (slow-expmod base (- power 1) mod)) mod))))


