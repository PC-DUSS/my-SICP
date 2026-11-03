#!/usr/bin/guile -s
!#
;; Convert the sum procedure to produce an iterative process rather than a
;; recursive process. This reduces memory consumption by avoiding having to
;; remember many deferred operations. Fill the missing expressions in the
;; following definition:
;;
;; (define (sum term a next b)
;;   (define (iter a result)
;;     (if ⟨??⟩
;;         ⟨??⟩
;;         (iter ⟨??⟩ ⟨??⟩)))
;;   (iter ⟨??⟩ ⟨??⟩))
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-02
;;
;; Copyright 2026 Pierre C. Dussault. See the LICENSE file for details.
;;
;; Code:
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))


(define (old-sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))


(define (1+ x)
  (+ x 1))


(define (inc x)
  (+ x 1))


(define (cube x)
  (* x x x))


(define (identity x) x)


(define (sum-cubes a b)
  (sum cube a 1+ b))


(define (sum-integers a b)
  (sum identity a 1+ b))


(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))


(define (integral f a b dx)
  ;; We can now leverage the sum procedure to build a more complex summation.
  ;; Here, we will calculate the integral of a given function between points a
  ;; and b using our sum procedure abstraction.
  (define (add-dx x)
    (+ dx x))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))


(define (simpson f a b n)
  (if (not (even? n))
    (begin
      (display "(simpson f a b n): invalid n. n should be an even integer.\n")
      (exit 1)))
  (define h (/ (- b a) n))
  (define (term k)
    (* (f (+ a (* k h)))
       (if (or (= k 0) (= k n))
           1
           (+ 2 (* 2 (remainder k 2))))))
  (* (/ h 3.0) (sum term 0 inc n)))


(define (main)
  ;;(display "sum-cubes = ") (display (sum-cubes 1 10)) (newline)
  ;;(display "sum-integers = ") (display (sum-integers 1 10)) (newline)
  ;;(display "pi-sum = ") (display (* 8 (pi-sum 1 750000))) (newline)
  (display "integral(cube) = ") (display (integral cube 0 1 0.001)) (newline)
  (display "simpson(cube) = ") (display (simpson cube 0 1 2)) (newline)
  (display "simpson(cube) = ") (display (simpson cube 0 1 100)) (newline)
  (display "simpson(cube) = ") (display (simpson cube 0 1 1000)) (newline))


(main)


