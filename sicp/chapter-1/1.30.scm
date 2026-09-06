(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (+ result (term a)))))
  (iter a 0))

(define (cube x) (* x x x))
(define (square x) (* x x))
(define (identity x) x)

(define (inc x) (+ x 1))

(define (sum-integers a b)
  (sum identity a inc b))

(define (sum-squares a b)
  (sum square a inc b))

(define (sum-cubes a b)
  (sum cube a inc b))

(define a 1)
(define b 4)
(sum-integers a b)
(sum-squares a b)
(sum-cubes a b)