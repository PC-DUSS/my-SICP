#!/usr/bin/guile -s
!#
(define (exponentiation)
  (define (exp1 base n)
    ;; Exponentiation using simple recursion.
    ;;
    ;; Requires O(n) time and O(n) space.
    (if (= n 0)
        1
        (* base (exp1 base (- n 1)))))

  (define (exp2 base n)
    ;; Exponentation using iteration.
    ;;
    ;; Requires O(n) time but only O(1) space (we are summarizing the data that
    ;; needs to be kept at each instance of the procedure call, rather than
    ;; forcing the program to keep the state of all previous procedure calls
    ;; until the base case is reached). Reduces the amount of space required to
    ;; only the variables that are used to keep the state from start to finish.
    ;; In this case, 'counter' and 'accumulator'.
    ;;
    ;; Tip: in general, iterative techniques in lisp still use recursion, but
    ;; require passing a counter and an accumulator variable, instead of
    ;; bubbling up values once a base case has been hit.
    (define (exp-iter b counter accumulator)
      (if (= counter 0)
          accumulator
          (exp-iter b (- counter 1) (* b accumulator))))
    (exp-iter base n 1))

  (define (exp3 base n)
    ;; Exponentation by squaring.
    ;;
    ;; Requires O(log(n)) time and O(log(n)) space. This algorithm cannot really
    ;; use an accumulator and a counter to reduce the amount of space consumed,
    ;; but it is much more efficient in the amount of time consumed.
    (define (sqr x)
      (* x x))
    (if (= n 0)
        1
        (if (= 0 (remainder n 2))
            (sqr (exp3 base (/ n 2)))
            (* base (exp3 base (- n 1))))))

  (define (exp4 b n)
    ;; TODO Trying to add an accumulator to the exponentiation by squaring
    ;; method, to reduce the amount of space used to O(1). SEEMS IMPOSSIBLE.
    ;;
    ;; REVIEW I don't think this can work, due to the call to 'sqr' taking an
    ;; invalid accumulator value (the accumulator it takes is the currently
    ;; accumulated one, rather than the value of accumulator when n was n/2).
    (define (sqr x) (* x x))

    (define (exp-sqr-iter b counter accumulator)
      (if (= counter 0)
          accumulator
          (if (= (remainder counter 2) 0)
              (sqr (exp-sqr-iter b (/ counter 2) accumulator))
              (exp-sqr-iter b (- counter 1) (* b accumulator)))))

    (exp-sqr-iter b n 1))
  
  (display (exp1 10 10)) (newline)
  (display (exp2 10 10)) (newline)
  (display (exp3 10 10)) (newline)
  (display (exp4 10 10)) (newline))


(exponentiation)
