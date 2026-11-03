(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))


(define (main)
  (display "pi / 8.0 = ") (display (/ 3.14159 8.0)) (newline)
  (display "pi-sum = ") (display (pi-sum 1 753500)) (newline))


(main)
