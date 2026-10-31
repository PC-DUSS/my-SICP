#!/usr/bin/guile -s
!#
;; Ex1.14 Different ways to make change for a given amount of money. Possible
;; coins are 1c, 5c, 10c, 25c and 50c.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-02-16
(define (ex1.14)
  ;; Algorithm (linear recursive process):
  ;; The amount of ways to make change for an amount 'a' from 'n' different
  ;; possible coins is equal to (number of ways to make change for 'a' with all
  ;; but the first type of coin) + (number of ways to make change for 'a - n')
  ;; with all types of coins.
  ;;
  ;; Edge cases:
  ;; (if amount = 1), ways-to-make-change = 1
  ;; (if amount = 0), ways-to-make-change = 0
  ;; (if n = 0), ways-to-make-change = 0
  (define (count-change amount)
    (cc amount 5))

  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount (- kinds-of-coins 1))
                   (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

  (define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))

  (display (count-change 11)) (newline)
  (display (count-change 55)) (newline))

(ex1.14)

;; Recursive process tree for (cc).
;;
;; Reminder:
;; * space order of growth is the depth of the longest branch.
;; * steps order of growth is the total amount of end leaf nodes.
;;
;; (cc 11 5)
;; (+ (cc 11 4) (cc (- 39) 5))
;; (+ (+ (cc 11 3) (cc (- 14) 4)) 0)
;; (+ (+ (+ (cc 11 2) (cc 1 3)) 0) 0)
;; (+ (+ (+ (+ (cc 11 1) (cc 6 2)) (+ (cc 1 2) (cc (- 9) 3))) 0) 0)
;; (+ (+ (+ (+ (+ (cc 11 0) (cc 10 1)) (+ (cc 6 1) (cc 1 2))) (+ (+ (cc 1 1) (cc (- 4) 2)) 0)) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ (cc 10 0) (cc 9 1))) (+ (+ (cc 6 0) (cc 5 1)) (+ (cc 1 1) (cc (- 4) 2)))) (+ (+ (+ (cc 1 0) (cc 0 1)) 0) 0)) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ (cc 9 0) (cc 8 1)))) (+ (+ 0 (+ (cc 5 0) (cc 4 1))) (+ (+ (cc 1 0) (cc 0 1)) 0))) (+ (+ (+ 0 1) 0) 0)) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ (cc 8 0) (cc 7 1))))) (+ (+ 0 (+ 0 (+ (cc 4 0) (cc 3 1)))) (+ (+ 0 1) 0))) (+ (+ 1 0) 0)) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 7 0) (cc 6 1)))))) (+ (+ 0 (+ 0 (+ 0 (+ (cc 3 0) (cc 2 1))))) (+ 1 0))) (+ 1 0)) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 6 0) (cc 5 1))))))) (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 2 0) (cc 1 1)))))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 5 0) (cc 4 1)))))))) (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 1 0) (cc 0 1))))))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 4 0) (cc 3 1))))))))) (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1)))))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 3 0) (cc 2 1)))))))))) (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1))))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 2 0) (cc 1 1))))))))))) (+ (+ 0 (+ 0 (+ 0 (+ 0 1)))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ (cc 1 0) (cc 0 1)))))))))))) (+ (+ 0 (+ 0 (+ 0 1))) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1))))))))))) (+ (+ 0 (+ 0 1)) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1)))))))))) (+ (+ 0 1) 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1))))))))) (+ 1 1)) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1)))))))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1))))))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1)))))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (+ 0 1))))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 1)))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 (+ 0 1))) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 (+ 0 1)) 2) 1) 0) 0)
;; (+ (+ (+ (+ (+ 0 1) 2) 1) 0) 0)
;; (+ (+ (+ (+ 1 2) 1) 0) 0)
;; (+ (+ (+ 3 1) 0) 0)
;; (+ (+ 4 0) 0)
;; (+ 4 0)
;; 4
;;
;; What is the order of growth for steps taken? (leaf nodes)
;; What is the order of growth for space consumed? (depth of longest branch)
