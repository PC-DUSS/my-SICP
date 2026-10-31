#!/usr/bin/guile -s
!#
;; Change this constant to the amount for which you want to make change, in
;; cents.
(define AMOUNT_TO_MAKE_CHANGE 250)

(define (ways-to-make-change amount)
  ;; Return the amount of different ways to make change for a given amount of
  ;; money in cents.

  ;; Constant for the largest supported denomination-rank as of now. Update this
  ;; constant alongside the "(denomination-value rank)" procedure if you want to
  ;; add or remove supported denominations. Note that you may want to modify the
  ;; "(denomination-value rank)" procedure without necessarily changing this
  ;; constant if you want to modify denomination values but don't need more
  ;; denominations than the amount currently specified by the constant.
  (define largest-supported-denomination-rank 5)

  (define (denomination-value rank)
    ;; Return the currency value of the given denomination rank.
    ;; The values of each rank are as follows:
    ;;     5 => 50 cents
    ;;     4 => 25 cents
    ;;     3 => 10 cents
    ;;     2 => 5 cents
    ;;     1 => 1 cent
    ;;
    ;; Returns -1 if the passed denomination rank is invalid.
    (cond ((= rank 1) 1)
          ((= rank 2) 5)
          ((= rank 3) 10)
          ((= rank 4) 25)
          ((= rank 5) 50)
          (else -1)))

  (define (make-change amount-remaining denomination-rank)
    ;; Try to make change for the given amount, using a given denomination-rank
    ;; as a given starting point for cutting down the amount. See
    ;; "(denomination-value rank)" for the currency value of each denomination
    ;; rank.

    (cond
     ;; If amount-remaining == 0, then we have found a successful way to make
     ;; change. Add one to the amount of ways ot make change found by returning 1
     ;; from this call instance of the procedure.
     ((= amount-remaining 0) 1)
     
     ;; Else, if there aren't any other possible denominations to try, or if the
     ;; amount-remaining has fallen below 0, then the current attempt is not a
     ;; valid way to make change. The current call instance of the procedure
     ;; returns 0, effectively not adding to the sum of possible ways to make
     ;; change.
     ((or (= denomination-rank 0) (< amount-remaining 0)) 0)
     
     ;; Else, we haven't finished making change for the current attempt.
     ;; Keep trying possible combinations:
     ;; 1) Try (again) to subtract the current denomination from the
     ;;    amount-remaining.
     ;; 2) Make change with all other denominations smaller than the current
     ;;    one.
     ;;
     ;; Sum the result of all attempts together. Since the procedure returns 1
     ;; when we have found a successful way to make change with the current
     ;; denomination, and 0 when the attempt is unsuccessful, the sum at the end
     ;; will represent the amount of successful ways to make change.
     (else (+ (make-change (- amount-remaining
                              (denomination-value denomination-rank))
                           denomination-rank)
              (make-change amount-remaining (- denomination-rank 1))))))

  ;; Start making change with the largest supported denomination.
  (make-change amount largest-supported-denomination-rank))


(display (ways-to-make-change AMOUNT_TO_MAKE_CHANGE)) (newline)
