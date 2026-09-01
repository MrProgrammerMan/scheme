(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; The value returned from the if is a procedure.
;; The procedure is + if b is positive, - otherwise.
;; The result is the same as adding the absolute value of b to a.
;; b > 0 -> a + b = a + |b|
;; b <= 0 -> a - b = a - (-|b|) = a + |b|