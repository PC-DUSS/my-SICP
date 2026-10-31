#!/usr/bin/guile -s
!#
;; Define a procedure to calculate the square root of a number by using Newton's
;; successive approximations method.
;;
;; Example:
;; Guess    Quotient               Average
;; 1        (2/1) = 2              ((2 + 1)/2) = 1.5
;; 1.5      (2/1.5) = 1.3333       ((1.3333 + 1.5)/2) = 1.4167
;; 1.4167   (2/1.4167) = 1.4118    ((1.4167 + 1.4118)/2) = 1.4142
;; 1.4142......
;;
;; Make an initial guess somehow.
;; Compute the quotient of x over the guess (x/guess).
;; Compute the average of the guess and of (x/guess).
;; Use this result as your next guess.
;; Repeat the process until you get an exact match.
(define (avg num1 num2)
  (/ (+ num1 num2) 2.0))

(define (guess-good? guess radicand)
  (< (abs (- (* guess guess) radicand)) 0.001))

(define (better-guess guess radicand)
  (avg guess (/ radicand guess)))

(define (sqrt-iter guess radicand)
  (if (guess-good? guess radicand)
      guess
      (sqrt-iter (better-guess guess radicand) radicand)))

(define (init-guess radicand) 1.0)

(define (newton-sqrt radicand)
  (sqrt-iter (init-guess radicand) radicand))

;; ex1.6 Answer: it works just fine!
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-sqrt-iter guess radicand)
  (new-if (guess-good? guess radicand)
      guess
      (sqrt-iter (better-guess guess radicand) radicand)))

(define (new-newton-sqrt radicand)
  (new-sqrt-iter (init-guess radicand) radicand))

(define (ex1-6)
  (define new-result (new-sqrt-iter 10.0 624.0))
  (display new-result) (newline))

;; ex1.7
;; For very small numbers, the precision cutoff (0.001) may very well be greater
;; than the actual square root of the radicand. In that case, the program would
;; result in a square root of 0. Also, you could just lose some precision from
;; truncation errors earlier in the process.
;;
;; Example:
(define (ex1-7)
  (define small-result (newton-sqrt 0.0000001))
  (define large-result (newton-sqrt 100000000000))
  (display small-result) (newline)
  (display large-result) (newline)

  (define (better-newton-sqrt radicand)
    (define (better-guess-good? old-guess new-guess)
      (define rel-delta (/ (abs (- old-guess new-guess)) old-guess))
      (< rel-delta 0.001))

    (define (better-sqrt-iter old-guess guess radicand)
      (if (better-guess-good? old-guess guess)
          guess
          (better-sqrt-iter guess (better-guess guess radicand) radicand)))

    (better-sqrt-iter (init-guess radicand) 1000 radicand))

  (define new-small-result (better-newton-sqrt 0.0000001))
  (define new-large-result (better-newton-sqrt 100000000000))
  (display new-small-result) (newline)
  (display new-large-result) (newline)
  ;; The new method seems much better for smaller numbers. For larger numbers,
  ;; the previous method already worked well since 0.001 is a small number
  ;; relative to very large numbers.
  )

;; ex1.8
(define (ex1-8)
  (define (init-guess radicand) 1.0)
  (define (cbrt-guess-good? old-guess new-guess)
    (< (/ (abs (- old-guess new-guess)) old-guess) 0.001))

  ;; TODO change this procedure for cube root Newton method.
  (define (cbrt-better-guess guess radicand)
    (/ (+ (/ radicand (* guess guess)) (* 2.0 guess)) 3.0))

  (define (cbrt-iter old-guess guess radicand)
    (if (cbrt-guess-good? old-guess guess)
        guess
        (cbrt-iter guess (cbrt-better-guess guess radicand) radicand)))

  (define (newton-cbrt radicand)
    (cbrt-iter (init-guess radicand) 1000 radicand))

  (display (newton-cbrt 27)) (newline)
  (display (newton-cbrt 1000)) (newline)
  (display (newton-cbrt 10000000000)) (newline)
  (display (newton-cbrt 0.0000000001)) (newline))

;; Main program
(define (main)
  (define result (sqrt-iter 10.0 624.0))
  (display result) (newline)
  ;; Exercises
  (ex1-6)
  (ex1-7)
  (ex1-8))

(main)
