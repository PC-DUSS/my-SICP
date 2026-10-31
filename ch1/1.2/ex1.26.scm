;; Louis Reasoner says that his 'fast-prime?' version is running more slowly
;; than his 'prime?' version. Here is his 'fast-prime?' version:
;;
(define (expmod base power mod)
  (cond ((= power 0) 1)
        ((even? power) (remainder (* (expmod base (/ power 2) mod)
                                     (expmod base (/ power 2) mod))) mod)
        (else (remainder (* base (expmod base (- power 1) mod)) mod))))

;; See explanations in ex1_26_explanation.pdf and ex1_26.dia
