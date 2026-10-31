#!/usr/bin/guile -s
!#
;; Change the 'find-divisor' procedure to only test odd numbers after testing
;; the number 2, since if 2 is not a divisor, then no even number will be a
;; divisor either.
;;
;; Use the 'get-internal-run-time' procedure from the Guile API to complete this
;; exercise.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-10-30
;;
;; Code:
(define (main)

  (define (displayln x)
    (display x) (newline))

  (define (build-list lst elem)
    (if (eq? lst '())
        (list elem)
        (append lst (list elem))))

  (define (square x)
    (* x x))

  (define (find-divisor dividend test-divisor)
    (define (next n)
      (if (= n 2) 3 (+ n 2)))
    (if (> (square test-divisor) dividend)
        dividend
        (if (= (remainder dividend test-divisor) 0)
            test-divisor
            (find-divisor dividend (next test-divisor)))))

  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (prime? n)
    (= (smallest-divisor n) n))

  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (get-internal-run-time) start-time))
        #f))

  (define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (get-internal-run-time)))

  (define (search-primes-iter current end primes maxprimes)
    (define (showprimes)
      (newline) (newline) (displayln "List of primes found:")
      (for-each displayln primes))
    (cond ((and (> maxprimes 0) (= (length primes) maxprimes)) (showprimes))
          ((< current end)
            (if (timed-prime-test current)
                (search-primes-iter (+ current 1)
                                    end
                                    (build-list primes current)
                                    maxprimes)
                (search-primes-iter (+ current 1)
                                    end
                                    primes
                                    maxprimes)))
          (else (showprimes))))

  (define (search-for-primes range-start range-end)
    (search-primes-iter range-start range-end '() 0))

  (define (search-for-first-three-primes range-start range-end)
    (search-primes-iter range-start range-end '() 3))

  (search-for-first-three-primes 1001 10000)
  (search-for-first-three-primes 10001 100000)
  (search-for-first-three-primes 100001 1000000)
  (search-for-first-three-primes 1000001 1002000)
  ;;(search-for-primes 1001 10000)
  ;;(search-for-primes 10001 100000)
  ;;(search-for-primes 100001 1000000)
  )


(main)
