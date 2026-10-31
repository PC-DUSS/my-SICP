;; Ex1.13
;;
;; Author: Pierre C. Dussault
;; Date: 2026-02-13
(define (main)
  (define my-libs-dir
    (simple-format #f "~A/Documents/programs/lisp/guile/my-libs" (getenv "HOME")))
  (add-to-load-path my-libs-dir)
  (use-modules (com.pierrecdussault my-math))

  (define golden-ratio (/ (+ 1 (my-sqrt 5)) 2))
  (define golden-ratio-prime (/ (- 1 (my-sqrt 5)) 2))
  (define n 15)
  (define fib-n (my-fibonacci n))
  (define target-num (/ (my-pow golden-ratio n) (my-sqrt 5)))
  (define target-num-prime (/ (- (my-pow golden-ratio n)
                                 (my-pow golden-ratio-prime n))
                              (my-sqrt 5)))
  ;;(simple-format #t "Golden-Ratio = ~S\n" golden-ratio)
  ;;(simple-format #t "Golden-Ratio-Prime = ~S\n" golden-ratio-prime)
  (display "Is fib(15) the closest integer to target-num?\n")
  (simple-format #t "fib(15) = ~S\n" fib-n)
  (simple-format #t "target-num = ~S\n" target-num)
  (display "Yes!\n\n")
  (display "Is target-num-prime == fib(15)?\n")
  (simple-format #t "target-num-prime = ~S\n" target-num-prime))

(main)
