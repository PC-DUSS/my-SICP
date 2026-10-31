;; The procedure:
;;
;;<<
;; (define (expmod base exp m)
;;   (remainder (fast-expt base exp) m))
;;>>

;; could have been used instead of our 'expmod' procedure when doing
;; 'fast-prime?' to achieve a correct result, but the execution time would have
;; been much longer for each number being tested. This is because doing this
;; outright calculates the full exponential number for each number being tested.
;; The 'expmod' procedure calculates the modulus at intermediate steps of the
;; exponentiation, on much smaller numbers, and uses a property of modulo to
;; calculate the correct final modulus that would have been even if we had
;; calculated the modulus of the full exponential number.
;;
;; Here is the comparison:
;;
;; Full exponentiation, then modulo:
;; (expmod 192 1001 1001)
;; (remainder (fast-exp 192 1001) 1001)
;; (remainder (fast-exp 192 1001) 1001)
;; (remainder 3.84e+2285 1001)
;; computation too expensive [LOL]
;;
;; Modulo at each partial step of fast-exp:
;; (expmod 192 1001 1001)
;; (remainder (* 192 (expmod 192 1000 1001)) 1001)
;; (remainder (* 192 (remainder (square (expmod 192 500 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (expmod 192 250 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (expmod 192 125 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (expmod 192 124 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (expmod 192 62 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (expmod 192 31 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (expmod 192 30 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (expmod 192 15 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (expmod 192 14 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (expmod 192 7 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (expmod 192 6 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (expmod 192 3 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (expmod 192 2 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (expmod 192 1 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (expmod 192 0 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 1) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder 192 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square 192) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder 36864 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 828) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder 158976 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square 818) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 456) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square (remainder 87552 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder (square 465) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 (remainder 216225 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (* 192 9) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder 1728 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 (remainder 528529 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder (* 192 1) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square (remainder 192 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder (square 192) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square (remainder 36864 1001)) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder (square 828) 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 (remainder 685584 1001)) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder (* 192 900) 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square (remainder 172800 1001)) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder (square 628) 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square (remainder 394384 1001)) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder (square 991) 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square (remainder 982081 1001)) 1001)) 1001)
;; (remainder (* 192 (remainder (square 100) 1001)) 1001)
;; (remainder (* 192 (remainder 10000 1001)) 1001)
;; (remainder (* 192 991) 1001)
;; (remainder 190272 1001)
;; 82
