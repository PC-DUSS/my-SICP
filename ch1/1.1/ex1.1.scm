#!/usr/bin/guile -s
!#
;; Exercises for chapter 1.1.6

;; ex1.1: Below is a sequence of expressions. What is
;; the result printed by the interpreter in response to each ex-
;; pression? Assume that the sequence is to be evaluated in
;; the order in which it is presented.
;;
;; 10
;; (+ 5 3 4)
;; (- 9 1)
;; (/ 6 2)
;; (+ (* 2 4) (- 4 6))
;; (define a 3)
;; (define b (+ a 1))
;; (+ a b (* a b))
;; (= a b)
;; (if (and (> b a) (< b (* a b)))
;;     b
;;     a)
;; (cond ((= a 4) 6)
;;       ((= b 4) (+ 6 7 a))
;;       (else 25))
;; (+ 2 (if (> b a) b a))
;; (* (cond ((> a b) a)
;;          ((< a b) b)
;;          (else -1))
;;    (+ a 1))
;;
;; Reasoning space
;;(define a 3)
;;(+ a (+ a 1) (* a (+ a 1)))
;;(+ 3 (+ 3 1) (* 3 (+ 3 1)))
;;(+ 3 4 (* 3 4))
;;(+ 3 4 12)
;;19
;;
;; Answer:
(display 10)
(newline)
(display 12)
(newline)
(display 8)
(newline)
(display 3)
(newline)
(display 6)
(newline)
(newline)  ;; (define a 3)
(newline)
(newline) ;;  (define b (+ a 1))
(newline)
(display 19)
(newline)
(display #f)
(newline)
(display 4)
(newline)
(display 16)
(newline)
(display 6)
(newline)
(display 16)
(newline)

;; ex1.2
(define my-result (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
                     (* 3 (- 6 2) (- 2 7))))
(display my-result)
(newline)

;; ex1.3
(define (sum-of-squares a b)
  (+ (* a a) (* b b)))

(define (two-largest a b c)
  (cond ((and (> a b) (> b c)) (list a b))
        ((and (> a b) (> c b)) (list a c))
        ((and (> b a) (> c a)) (list b c))
        ((and (> b a) (> a c)) (list a b))
        (else "ERROR")))

(define (sum-of-squares-of-two-largest a b c)
  (apply sum-of-squares (two-largest a b c)))

(display (sum-of-squares-of-two-largest 10 (- 5) 3))
(newline)
(display (sum-of-squares-of-two-largest 3 (- 5) 10))
(newline)
(display (sum-of-squares-of-two-largest (- 5) 3 10))
(newline)
(display (sum-of-squares-of-two-largest (- 5) 10 3))
(newline)
(display (sum-of-squares-of-two-largest 10 3 (- 5)))
(newline)
(display (sum-of-squares-of-two-largest 3 10 (- 5)))
(newline)

;; ex1.4
;; If b is not superior to 0, subtract b from a. Otherwise, add b to a.
;; Basically, add the absolute value of b to a.

;; ex1.5
;; (define (p) (p))
;; (define (test x y)
;;   (if (= x 0) 0 y))
;;
;; en evaluate the expression:
;; (test 0 (p))
;;
;; What behavior will Ben observe with an interpreter that
;; uses applicative-order evaluation? What behavior will he
;; observe with an interpreter that uses normal-order evalu-
;; ation? Explain your answer. (Assume that the evaluation rule
;; for the special form if is the same whether the in-
;; terpreter is using normal or applicative order: e predi-
;; cate expression is evaluated ﬁrst, and the result determines
;; whether to evaluate the consequent or the alternative ex-
;; pression.)
;;
;;(test 0 (p))
;;
;; Answer: In applicative-order evaluation, the program enters endless recursion
;; while trying to evaluate (define (p) (p)). This function definition define's
;; function p as function p (creating endless recursion). In normal-order
;; evaluation, the program would return 0, because it would never have to
;; actually evaluate (p). The if-expression, evaluating a truthy expression,
;; would return its conditional expression, which is 0, and would never evaluate
;; (p).
