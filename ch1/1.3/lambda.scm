;; Constructing procedures with lambda, avoiding having to define procedures
;; only for a one-time use.
(define (square x) (* x x))


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))


(define (pi-sum a b)
  ;; With lambda, we can rewrite our pi-sum procedure without needing any
  ;; auxiliary procedures.
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))


(define (integral f a b dx)
  ;; Likewise for our integral procedures. We can do away with the add-dx
  ;; procedure and simply use a lambda.
  (* dx (sum f
             (+ a (/ dx 2.0))
             (lambda (x) (+ x dx))
             b)))


;; A lambda procedure is just as much a procedure as one created in a 'define'
;; expression. In fact, these two expressions create the exact same procedure.
(define (plus4 x) (+ x 4))
(define plus4 (lambda (x) (+ x 4)))


(define (main)
  ;; Just like any expression that has a procedure as its value, we can use a
  ;; lambda as an operator (or anywhere where a procedure name is expected).
  (display ((lambda (x y z) (+ x y (square z)))
            1 2 3))
  (newline)
  )


(main)
