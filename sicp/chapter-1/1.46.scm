(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
          guess
          (iter next))))
  (lambda (guess) (iter guess)))

(define (good-enough?-sqrt tolerance x guess next)
  (< (abs (- (square guess) x)) tolerance))

(define (square x) (* x x))

(define (average a b)
  (/ (+ a b) 2))

(define (improve-sqrt x guess)
  (average guess (/ x guess)))

(define (sqrt-iter guess x tolerance)
  ((iterative-improve
    (lambda (guess next) (good-enough?-sqrt tolerance x guess next))
    (lambda (guess) (improve-sqrt x guess))) guess))

(sqrt-iter 1.0 2 0.0001)
(sqrt-iter 1.0 3 0.0001)
(sqrt-iter 1.0 9 0.0001)
(sqrt-iter 1.0 16 0.0001)
(sqrt-iter 1.0 16 0.00000001)

(define (good-enough?-fixed-point tolerance v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define (improve-fixed-point f guess)
  (f guess))

(define (cos-fixed-point guess tolerance)
  ((iterative-improve
    (lambda (guess next) (good-enough?-fixed-point tolerance guess next))
    (lambda (guess) (improve-fixed-point cos guess))) guess))

(cos-fixed-point 1.0 0.00001)