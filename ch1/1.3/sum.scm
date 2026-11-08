;; Generalize the concept of summation for any type of summation.
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))


(define (1+ x)
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

  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))


(define (simpson-integral f a b n)
  ;; Be careful not to override the arguments received by simpson-integral. Use
  ;; different argument names in your local functions. We need to keep 'a' from
  ;; simpson-integral intact in the scope of 'sum'.
  ;;
  ;; a: a
  ;; b: end (equivalent to n-1) = n * h + a - h
  ;; term: f-adj (see below)
  ;; next: a + h
  ;; k: determine via procedure call with 'a' as an argument
  (define start a)
  (define end (+ (* n h) a (- h)))  ;; equivalent to (n-1)
  (define h (/ (- b a) (* n 1.0)))
  (define (k a)  ;; this procedure is a closure
    (+ (/ (- a start) h) 1))

  (define (f-adj a)
    (* (+ 2 (* 2 (remainder (k a) 2))) (f a))))

  (define (next a)
    (+ a h))

  (* (/ h 3.0)
     (+ (f start)
        (sum f-adj (+ start h) next end)
        (f (+ a (* n h))))))


(define (main)
  (display "sum-cubes = ") (display (sum-cubes 1 10)) (newline)
  (display "sum-integers = ") (display (sum-integers 1 10)) (newline)
  (display "pi-sum = ") (display (* 8 (pi-sum 1 750000))) (newline)
  (display "integral(cube) = ") (display (integral cube 0 1 0.001)) (newline)
  (display "simpson-integral(cube) = ") (display (simpson-integral cube 0 1 100)) (newline)
  (display "simpson-integral(cube) = ") (display (simpson-integral cube 0 1 1000)) (newline)
  )


(main)
