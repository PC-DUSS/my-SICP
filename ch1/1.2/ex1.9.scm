#!/usr/bin/guile -s
!#
;; ex1.9
;; Initial setup
(define (inc a) (+ a 1))
(define (dec b) (- b 1))
;; 1st variant
(define (r+ a b)
  (if (= a 0)
      b
      (r+ (dec a) b)))

;; 2nd variant
(define (i+ a b)
  (if (= a 0)
      b
      (i+ (dec a) (inc b))))

;; 1st variant executes as follows:
;;
;; => (inc (r+ (dec 4) 5))
;; => (inc (inc (r+ (dec 3) 5)))
;; => (inc (inc (inc (r+ (dec 2) 5))))
;; => (inc (inc (inc (inc (r+ (dec 1) 5)))))
;; => (inc (inc (inc (inc (r+ 0 5)))))  --> trigger the base case of (= a 0)
;; => (inc (inc (inc (inc 5))))
;; => (inc (inc (inc 6)))
;; => (inc (inc 7))
;; => (inc 8)
;; => 9
;;
;; This represents a recursive process (latent computation that eventually bubbles back up once a base case is hit).

;; 2nd variant executes as follows:
;;
;; => (+ (dec 4) (inc 5))
;; => (+ (dec 3) (inc 6))
;; => (+ (dec 2) (inc 7))
;; => (+ (dec 1) (inc 8))
;; => (+ 0 9)  -> trigger the base case of (= a 0)
;; => 9
;;
;; This represents an iterative process (state variable to conserve progression, with a boundary to the amount of iterations).
