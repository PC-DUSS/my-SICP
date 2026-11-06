#!/usr/bin/guile -s
!#
(define (main)
  (define (gcd a b)
    ;; Eucledian algorithm.
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  
  (gcd 206 40))

;; Normal-order (substitution method). The only forced evaluation will happen in
;; the if-expression. if-expression predicates are always evaluated, even in
;; normal-order evaluation (which normally only uses substitution).
;;
;; (gcd 206 40)
;; -> (if (= 40 0) e1 e2) XXX Evaluate e2
;;
;; (gcd 40 (remainder 206 40))
;; -> (if (= (remainder 206 40) 0) e1 e2)
;; -> (if (= 6 0) e1 e2) XXX Evaluate e2
;;
;; (gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
;; -> (if (= (remainder 40 (remainder 206 40)) 0) e1 e2)
;; -> (if (= (remainder 40 6) 0) e1 e2)
;; -> (if (= 4 0) e1 e2) XXX Evaluate e2
;;
;; (gcd (remainder 40 (remainder 206 40))
;;      (remainder (remainder 206 40)
;;                 (remainder 40 (remainder 206 40))))
;; -> (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;           0) e1 e2)
;; -> (if (= (remainder 6 (remainder 40 6)) 0) e1 e2)
;; -> (if (= (remainder 6 4) 0) e1 e2)
;; -> (if (= 2 0) e1 e2) XXX Evaluate e2
;;
;; (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;      (remainder (remainder 40 (remainder 206 40))
;;                 (remainder (remainder 206 40)
;;                            (remainder 40 (remainder 206 40)))))
;; -> (if (= (remainder (remainder 40 (remainder 206 40))
;;                      (remainder (remainder 206 40)
;;                                 (remainder 40 (remainder 206 40))))
;;           0) e1 e2)
;; -> (if (= (remainder (remainder 40 6) (remainder 6 (remainder 40 6)))) e1 e2)
;; -> (if (= (remainder 4 (remainder 6 4))) e1 e2)
;; -> (if (= (remainder 4 2) 0) e1 e2)
;; -> (if (= 0 0) e1 e2) MATCHED. Now evaluate e1, which happens to be 'a'.
;;
;; (if (= 0 0)
;;     a
;;     e2)
;; -> (if (= 0 0)
;;        (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;        e2)
;; -> (if (= 0 0) (remainder 6 (remainder 40 6)) e2)
;; -> (if (= 0 0) (remainder 6 4) e2)
;; -> (if (= 0 0) 2 e2)
;; -> 2
;;
;; Normal-order: number of 'remainder' procedures performed = 14 ('b' five times) + 4 ('a' just once) = 18 total
;;
;; vs.
;;
;; Applicative-order (evaluate operands immediately)
;;
;; (gcd 206 40)
;; (gcd 40 (remainder 206 40))
;; (gcd 40 6)
;; (gcd 6 (remainder 40 6))
;; (gcd 6 4)
;; (gcd 4 (remainder 6 4))
;; (gcd 4 2)
;; (gcd 2 (remainder 4 2))
;; (gcd 2 0)
;; 2
;;
;; Applicative-order: number of 'remainder' procedures performed = 4 total

