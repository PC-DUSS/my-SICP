#!/usr/bin/guile -s
!#
;; Two different ways to add whole numbers:

;; This represents a linear iterative process.
(define (add-v1 x y)
  (if (= x 0)
      y
      (add-v1 (- x 1) (+ y 1))))
;; (+ 3 4)
;; (+ 2 5)
;; (+ 1 6)
;; (+ 0 7)
;; 7
;;
;; This is a linear iterative process.
;; Time complexity = O(n). Space complexity = O(1).
(display (add-v1 100000 100000)) (newline)


;; This represents a linear recursive process.
(define (add-v2 x y)
  (if (= x 0)
      y
      (+ 1 (add-v2 (- x 1) y))))
;; (+ 3 4)
;; (+ 1 (+ 2 4))
;; (+ 1 (+ 1 (+ 1 4)))
;; (+ 1 (+ 1 (+ 1 (+ 0 4))))
;; (+ 1 (+ 1 (+ 1 4)))
;; (+ 1 (+ 1 5))
;; (+ 1 6)
;; 7
;;
;; This is a linear recursive process.
;; Time complexity = 0(2n) ~ O(n). Space complexity = O(n).
(display (add-v2 100000 100000)) (newline)
