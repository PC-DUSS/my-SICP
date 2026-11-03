(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))


(define (main)
  (define my-sum (sum-integers 1 100))
  (display my-sum) (newline))


(main)
