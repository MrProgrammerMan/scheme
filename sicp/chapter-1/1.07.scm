;; For small numbers, the accuracy window of 0.001 can be too big to produce a valuable result.
;; The result of the test could be several times smaller or larger than the real root, and still be "good-enough?"
;; For large numbers, there is a different problem. Floating point numbers are generally stored in a way where more bits are dedicated to the whole number part the larger the number is.
;; This means that for very large numbers, there may not be enough accuracy to bring the result withing 0.001 of the real root.
;; This could cause infinite recursion, where rounding error of floating point arithmetic causese the guess to jump around the real root.

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                      x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average a b)
  (/ (+ a b) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt2 x)
  (sqrt-iter 1.0 x))

(define (square x) (* x x))

(sqrt2 9.0)
(sqrt2 2.0)
(display "There is not enough accuracy for small numbers:")
(newline)
(sqrt2 0.00001)
(sqrt2 0.000001)
(sqrt2 0.0000001)
(sqrt2 0.00000001)
(display "Large numbers can hang.")
(newline)
(display "Calculates fine: 81458784999999.992")
(newline)
(sqrt2 100000000000.0)
(sqrt2 1000000000000.0)
(sqrt2 81458784999999.992)
(display "Hangs: 81458784999999.993")
(newline)
;;(sqrt2 81458784999999.993)

(define (sqrt-iter2 guess old-guess x)
  (if (good-enough?2 guess old-guess x)
      guess
      (sqrt-iter2 (improve guess x)
                  guess
                  x)))

(define (good-enough?2 guess old-guess x)
  (< (abs (- 1 (abs (/ guess old-guess)))) 0.001))

(define (sqrt3 x)
  (sqrt-iter2 1.0 1000 x))

(sqrt3 9.0)
(sqrt3 2.0)
(display "There is now enough accuracy for small numbers:")
(newline)
(sqrt3 0.00001)
(sqrt3 0.000001)
(sqrt3 0.0000001)
(sqrt3 0.00000001)
(display "Large numbers work too.")
(newline)
(display "Calculates fine: 81458784999999.992")
(newline)
(sqrt3 100000000000.0)
(sqrt3 1000000000000.0)
(sqrt3 81458784999999.992)
(display "This too:")
(sqrt3 81458784999999.993)