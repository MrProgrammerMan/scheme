(define (square x) (* x x))

(define (sum-squares a b) (+ (square a) (square b)))

(define (sum-squares-pair p) (sum-squares (car p) (cdr p)))

(define (two-largest a b c)
  (if (< a b)
      (if (< a c) (cons b c) (cons a b))
      (if (< b c) (cons a c) (cons a b))))

(define (square-two-largest a b c) (sum-squares-pair (two-largest a b c)))

(square-two-largest 2 3 4)
(square-two-largest 1 3 4)
(square-two-largest 2 3 5)