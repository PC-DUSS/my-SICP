(define (cube x)
  (* x x x))


(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))


(define (main)
  (define my-sum (sum-cubes 1 10))
  (display my-sum) (newline))


(main)
