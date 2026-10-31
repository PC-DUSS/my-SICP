;; Conditional evaluation in Scheme is achieved with the 'cond' procedure.
;; 'cond' evaluates one or more predicates. Each predicate is evaluated in
;; order. The first predicate that evaluates to true causes the 'cond'
;; expression to return its associate value.
;;
;;(cond (test1 return-value1) (test2 return-value2) (test3 return-value3) ...)
;;
;; Here is an example with an absolute value function.
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) x)
        ((< x 0) (- x))))

;; You can also express a catch-all predicate with 'else'.
(define (abs2 x)
  (cond ((< x 0) (- x))
        (else x)))

(display (abs (- 15)))
(newline)

(display (abs2 (- 15)))
(newline)

;; You can also use the 'if' conditional procedure. 'if' is used when there are only two possible cases.
;; It has the following form: (if <predicate> <consequent> <alternative>)
(define (abs3 x)  ;; If x<0 return -x, otherwise return x
  (if (< x 0)
      (- x)
      x))

;; There are also logical composition operators that we can use to build compound predicates.
;;
;; 1) 'and' Returns false, or the result of the last expression.
;; (and <e1> <e2> ...)
;;
;; 2) 'or' Returns the result of the first expression to evaluate to true, or false otherwise.
;; (or <e1> <e2> ...)
;;
;; 3) 'not' Returns true if the expression evaluates to false, or false otherwise.
;; (not <e>)
;;
;; Notice that 'and' and 'or' are special forms and aren't regular procedures,
;; since some of their expression arguments may never be evaluated if the 'and'
;; or the 'or' returns early, whereas 'not' is regular procedure.
(define my-x 11)
(display (and (> my-x 5) (< my-x 10)))
(newline)
(display (>= my-x 11))
(newline)

(define (>? a b) (if (> a b) #t #f))
(display (>? 10 my-x))
(display (>? 12 my-x))
(newline)
