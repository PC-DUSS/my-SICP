#!/usr/bin/guile -s
!#
;; Linear recursion and iteration

;; Here is one way to define the factorial procedure. This is the classical
;; recursive tail-call method. This recursive process builds up a chain of
;; deferred operations, only starting to make computations once the recursive
;; chain hits the 'base case'. Until the base case is encountered, the process
;; must keep track of all the latest operations. These operations grow linearly
;; with n (proportional to n). Such a process is called a 'linear recursive
;; process'.
(define (recursive-factorial n)
  (if (= n 1)
      1
      (* n (recursive-factorial (- n 1)))))


;; Here is another way to define the factorial procedure. This still technically
;; uses recursion, but it is more of an iteration process. This process does not
;; grow and shrink, rather its size is relatively constant. An iterative process
;; can be described by a constant number of state variables (here, they are
;; 'product' 'counter' and 'max-count'). The number of iterations grows linearly
;; with n. Such a process is called a 'linear iterative process'.
(define (iterative-factorial n)
  ;; Here, the variable n is available thanks to being inside the scope of
  ;; (iterative-factorial n).
  (define max-count n)
  (define (iter product counter)
    (if (> counter max-count)
        product
        (iter (* product counter) (+ 1 counter))))
  (define init-product 1)
  (define init-counter 1)
  (iter init-product init-counter))

;; Main program.
(define (main)
  (display (recursive-factorial 6)) (newline)
  (display (iterative-factorial 6)) (newline))

(main)


;; Be careful not to confuse the concept of a 'recursive process' with the
;; notion of a 'recursive procedure'. In Scheme, and iterative process consumes
;; constant space (memory), even if the iterative process is described by a
;; recursive procedure. An implementation with this property is called
;; 'tail-recursive'.
;;
;; Tail-recursive implementations allow iteration through ordinary procedure
;; calls, so that iterative constructs act only as syntactic sugar.
