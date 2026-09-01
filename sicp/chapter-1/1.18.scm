(define (mult-iter a b)
  (define (mult a b carry)
    (cond ((= b 1) (+ a carry))
          ((even? b) (mult (double a) (halve b) carry))
          (else (mult a (- b 1) (+ carry a)))))
  (mult a b 0))

(define (halve x) (/ x 2))
(define (double x) (+ x x))

(mult-iter 2 4)
(mult-iter 10 15)
(mult-iter 6 7)