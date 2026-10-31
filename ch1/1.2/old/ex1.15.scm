#!/usr/bin/guile -s
!#
;; Ex1.15
;;
;; Author: Pierre C. Dussault
;; Date: 2026-02-16
(define (ex1.15)
  (define (cube x) (* x x x))
  
  (define (p x)
    (begin
      (display "in (p)") (newline)
      (- (* 3 x) (* 4 (cube x)))))
  
  (define (sine angle)
    (if (not (> (abs angle) 0.1))
        angle
        (p (sine (/ angle 3.0)))))
  
  (simple-format #t "(sine 12.15) = ~A\n" (sine 12.15))
  (simple-format #t "(sine 50.75) = ~A\n" (sine 100000)))

(ex1.15)

;; Recursion graph.
;; a) 'p' gets called 5 times.
;; b) O(n) time complexity, and O(n) space complexity.
;;
;; (sine 12.15)
;; (p (sine (/ 12.15 3)))
;; (p (sine (4.05)))
;; (p (p (sine (/ 4.05 3))))
;; (p (p (sine (1.35))))
;; (p (p (p (sine (/ 1.35 3)))))
;; (p (p (p (sine (0.45)))))
;; (p (p (p (p (sine (/ 0.45 3))))))
;; (p (p (p (p (sine (0.15))))))
;; (p (p (p (p (p (sine (/ 0.15 3)))))))
;; (p (p (p (p (p (sine (0.05)))))))
;; (p (p (p (p (p (0.05))))))
;; (p (p (p (p (- (* 3 0.05) (* 4 (cube 0.05)))))))
;; (p (p (p (p (- 0.15 (* 4 (0.000125)))))))
;; (p (p (p (p (- 0.15 0.0005)))))
;; (p (p (p (p (0.1495)))))
;; (p (p (p (- (* 3 0.1495) (* 4 (cube 0.1495))))))
;; (p (p (p (- 0.4485 (* 4 0.0033413623)))))
;; (p (p (p (- 0.4485 0.0133654492))))
;; (p (p (p (0.4351345508))))
;; (p (p (- (* 3 0.4351345508) (* 4 (cube 0.4351345508)))))
;; (p (p (- 1.3054036524 0.3295571188)))
;; (p (p 0.9758465336))
;; (p (- (* 3 0.9758465336) (* 4 (cube 0.9758465336))))
;; (p (- 2.9275396008 3.7171027188)))
;; (p (- 0.78956311808))
;; (- (* 3 (- 0.78956311808)) (* 4 (cube (- 0.78956311808))))
;; (- (-2.36868935424) (-1.96888591296))
;; (- 0.39980344128)
