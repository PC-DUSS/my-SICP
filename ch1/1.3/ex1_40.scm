#!/usr/bin/guile -s
!#
;; Define a 'cubic' procedure that can be used with our 'newtons-method'
;; procedure in expressions of the form:
;;   (newtons-method (cubic a b c) 1.0)
;;
;; The form of a cubic function is: x^3 + ax^2 + bx + c.
;;
;;
;; Reminder of the algorithm behind using Newton's method for finding
;; a zero:
;; 1) Determine the derivative of the given function g.
;; 2) Use g and the newly determined derivative of g to make a guess attempt
;;    using an initial input value (for example, of 1).
;; 3) Use the output from the first guess, and use that as an input in
;;    reapplying the Newton transform function, generating a new output.
;; 4) Repeat until the output is equal to input, which is an indication that
;;    g(x) is equal to 0, since the result of the fraction g(x)/g'(x) = 0,
;;    meaning that x is the only non-zero term on the right side of the
;;    equation, turning the equation into f(x) = x. This result gives you two
;;    important pieces of information: you know that this x-value is a
;;    fixed-point of the Newton's transform function (which is based on the
;;    derivative of the g function), AND that this x-value is a zero of the g
;;    function. The second information is the particularly valuable one. The
;;    Newton's method allows us to converge to a zero of a function. Some
;;    mathematical relationships between variables can be described as a
;;    function, and we can solve for a zero of the function in order to find a
;;    valid value for the relationship between those two variables, as in the
;;    square root relationship of x^2 - y = 0, where y is the radicand, and x is
;;    the square root which we are trying to find. By representing this
;;    relationship as g(x) = x^2 - y, and trying to find a zero where g(x) = 0,
;;    we find the value of input for which the equation balances. This input
;;    that balances g(x) = 0 is the square root of y by virtue of the definition
;;    of a square root. We can use this property of finding zeros to find values
;;    that satisfy a mathematical relationship.
;;
;; Author: Pierre C. Dussault
;; Date: 2026-11-19
;;
;; Copyright 2026 Pierre C. Dussault. See LICENSE file for details.
;;
;; Code:
(define dx 0.00001)


(define (even? x) (= 0 (remainder x 2)))


(define (square x) (* x x))


(define (cube x) (* x x x))


(define (pow b n)
  (define (iter b n adjust-factor)
    (cond ((= n 1) (* b adjust-factor))
          ((even? n) (iter (square b) (/ n 2) adjust-factor))
          (else (iter b (- n 1) (* b adjust-factor)))))
  (if (= n 0)
      1
      (iter b n 1.0)))


(define (cubic a b c)
  ;; Write a procedure which provides a cubic function that can be used
  ;; alongside Newton's method to approximate the zeroes of that cubic function.
  ;;
  ;; The reason this it is so useful to return a procedure in this case is
  ;; because when calling newtons-method, we want to be able to pass any cubic
  ;; function, but there are an infinite number of different cubic functions
  ;; with different parameters a b and c. This procedure allows us to pass any
  ;; cubic function, which will then be applied on an input value in
  ;; 'newton-transform'.
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))


(define (cubic->string a b c)
  ;; Return the string representation of a cubic function.
  (string-append "x^3 + "
                 (number->string a) "x^2 + "
                 (number->string b) "x + "
                 (number->string c)))


(define (fixed-point f guess)
  (let ((next (f guess))
        (tolerance 0.00001))
    (if (< (abs (- next guess)) tolerance)
        next
        (fixed-point f next))))


(define (deriv g)
    (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))


(define (newton-transform g)
  ;; Newton's transform is used to generate one guess within 'fixed-point'. It
  ;; will be used over and over until 'fixed-point' converges.
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))


(define (newtons-method g guess)
  ;; Use Newton's method to return a zero of the given function g(x). Provide an
  ;; initial starting guess to kick-off the fixed-point convergence of
  ;; 'newton-transform'.
  ;;
  ;; Remember that Newton's method of finding zeroes here makes repeated guesses
  ;; by attempting to find a fixed-point for the newton-transform function,
  ;; which also simultaneously satisfies g(x) = 0 which is what we're really
  ;; after. We just use the property of finding a fixed-point for f(x) (the
  ;; newton-transform function) to find a zero for g(x) (the function that we
  ;; provided for which we have an actual interest in finding its or one of its
  ;; zero(s)).
  (fixed-point (newton-transform g) guess))


(define (is-main?)
  (let ((filename "ex1_40.scm")
        (cli-first-arg (car (command-line))))
    (or (equal? cli-first-arg filename)
        (equal? cli-first-arg (string-append "./" filename)))))


(define (main)
  ;; Let's use our procedure to find a zero for some cubic functions. Our
  ;; results were confirmed good with the Wolfram Alpha calculator.
  (letrec ((a1 1) (b1 2) (c1 3)
           (a2 -0.5) (b2 3) (c2 -5)
           (a3 -3) (b3 -0.25) (c3 -2)
           (msg (string-append "zero of " (cubic->string a1 b1 c1) " = "
                               (number->string
                                 (newtons-method (cubic a1 b1 c1) 1))
                               "\nzero of " (cubic->string a2 b2 c2) " = "
                               (number->string
                                 (newtons-method (cubic a2 b2 c2) 1))
                               "\nzero of " (cubic->string a3 b3 c3) " = "
                               (number->string
                                 (newtons-method (cubic a3 b3 c3) 1))
                               "\n")))
    (display msg))
  (exit 0))


(if (is-main?) (main))

