#!/usr/bin/guile -s
!#
;; Modify the 'timed-prime-test' procedure to use fast-prime? (Fermat method),
;; and test each of the 3 first primes for each range previously provided.
;; Considering that the Fermat method has O(log(n)) time complexity, see how the
;; times to test primes in the 1000000+ range change compared to the times to
;; test primes in the 1000+ range.
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

  (define (even? x)
    (= (remainder x 2) 0))

  (define (pow base power)
    (define (pow-iter base power total)
      (cond ((= power 0) total)
            ((even? power) (pow-iter (square base) (/ power 2) total))
            (else (pow-iter base (- power 1) (* base total)))))
    (pow-iter base power 1))

  (define (expmod base power m)
    (cond ((= power 0) 1)
          ((even? power) (remainder (square (expmod base (/ power 2) m)) m))
          (else (remainder (* base (expmod base (- power 1) m)) m))))

  (define (fermat-test n)
    (let ((a 0))
      (if (< n 2)
          #f
          (begin
            (set! a (+ 1 (random (- n 1))))
            (= (expmod a n n) a)))))

  (define (fast-prime? n)
    (define (fast-prime-iter n times)
      (cond ((= times 0) #t)
            ((fermat-test n) (fast-prime-iter n (- times 1)))
            (else #f)))
    (fast-prime-iter n 15))

  (define (report-prime n elapsed-time)
    (newline)
    (display n)
    (display " *** ")
    (display elapsed-time))

  (define (start-prime-test n start-time)
    (if (fast-prime? n)
        (report-prime n (- (get-internal-run-time) start-time))
        #f))

  (define (timed-prime-test n)
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

  (search-for-first-three-primes 1001 2000)
  (search-for-first-three-primes 1000001 1002000)
  ;;(display (expmod 192 1033 1033)) (newline)
  )


(main)
