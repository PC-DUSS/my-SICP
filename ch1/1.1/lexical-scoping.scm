#!/usr/bin/guile -s
!#
;; Lexical Scoping: you do not have to declare procedure parameters if the
;; arguments that need to be used by the procedure can be taken from the outer
;; scope.
(define (lexical-scoping)
  (define (newton-cbrt radicand)
    (define (init-guess) 1.0)    

    (define (cbrt-guess-good? old-guess new-guess)
      (< (/ (abs (- old-guess new-guess)) old-guess) 0.001))

    (define (cbrt-better-guess guess)
      (/ (+ (/ radicand (* guess guess)) (* 2.0 guess)) 3.0))

    (define (cbrt-iter old-guess guess)
      (if (cbrt-guess-good? old-guess guess)
          guess
          (cbrt-iter guess (cbrt-better-guess guess))))

    (cbrt-iter (init-guess) 1000))

  (display (newton-cbrt 27)) (newline)
  (display (newton-cbrt 1000)) (newline)
  (display (newton-cbrt 10000000000)) (newline)
  (display (newton-cbrt 0.0000000001)) (newline))

(lexical-scoping)
