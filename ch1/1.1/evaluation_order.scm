;; The order of evaluation for compound procedures can work two ways:
;; 1) Incrementally evaluate all subexpressions and keeping each's result in
;;    order to evaluate the next layer of subexpressions.
;; 2) Or, substitute all parameters with the procedure definition, not
;;    evaluating anything until absolutely necessary. Evaluation only becomes
;;    absolutely necessary when the only arguments left are all primitives (when
;;    no more compound procedures are left).
;;
;; Here is an example with a function f(x) = y.
;;(define (square a) (* a a))
;;(define (sum-of-squares b c) (+ (square b) (square c)))
;;(define (f x) (sum-of-squares (+ x 1) (* x 2)))
;;
;; Calling (f 5) will lead to the two possible scenarios below.
;;
;; 1) Calculate all subexpressions, one by one.
;; => (f 5)
;; => (sum-of-squares (+ 5 1) (* 5 2))
;; => (sum-of-squares (6) (10))
;; => (+ (square 6) (square 10))
;; => (+ 36 100)
;; => 136
;;
;; 2) Only expand procedure definitions without evaluating any procedure. Only
;;    start evaluating once you are left with primitive procedures.
;; => (f 5)
;; => (sum-of-squares (+ 5 1) (* 5 2))
;; => (+ (square (+ 5 1)) (square (* 5 2)))
;; => (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))   ;; Now we can begin evaluating since the only remaining procedures are primitive procedures
;; => (+ (* 6 6) (* 10 10))
;; => (+ 36 100)
;; => 136
;;
;;
;; Option 1) is called 'Applicative-order evaluation', and is how most interpretors actually evaluate operations.
;; Option 2) is called 'Normal-order evaluation'.
