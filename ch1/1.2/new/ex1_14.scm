#!/usr/bin/guile -s
!#
;; Examining the process tree for (make-change) in make_change.scm.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-27

;; (make-change 6 5)
;;
;; (+ (make-change -44 5) (make-change 6 4))
;; (+ 0 (+ (make-change -19 4) (make-change 6 3)))
;; (+ 0 (+ 0 (+ (make-change -4 3) (make-change 6 2))))
;; (+ 0 (+ 0 (+ 0 (+ (make-change 1 2) (make-change 6 1)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ (make-change -4 2) (make-change 1 1)) (+ (make-change 5 1) (make-change 6 0))))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (make-change 1 1)) (+ (make-change 5 1) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ (make-change 0 1) (make-change 1 0))) (+ (+ (make-change 4 1) (make-change 5 0)) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (make-change 4 1) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (+ (make-change 3 1) (make-change 4 0)) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (+ (+ (make-change 2 1) (make-change 3 0)) 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (+ (+ (+ (make-change 1 1) (make-change 2 0)) 0) 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (+ (+ (+ (+ (make-change 0 1) (make-change 1 0)) 0) 0) 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 (+ 1 0)) (+ (+ (+ (+ (+ (+ 1 0) 0) 0) 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ (+ 0 1) (+ (+ (+ (+ (+ 1 0) 0) 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ 1 (+ (+ (+ 1 0) 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ 1 (+ (+ 1 0) 0)))))
;; (+ 0 (+ 0 (+ 0 (+ 1 (+ 1 0)))))
;; (+ 0 (+ 0 (+ 0 (+ 1 1))))
;; (+ 0 (+ 0 (+ 0 2)))
;; (+ 0 (+ 0 2))
;; (+ 0 2)
;; 2
;;
;; Time complexity = O(n^5). Space complexity = O(n).
