(define (sum term a next b)
  (define (iter result a)
    (if (> a b)
        result
        (iter (+ result (term a)) (+ a 1))))
  (iter a a))

(define (identity x) x)
(define (square x) (* x x))
(define (cube x) (* x x x))

(define (inc x) (+ x 1))

(define (sum-integers n)
  (sum identity 0 inc n))

(define (sum-squares n)
  (sum square 0 inc n))

(define (sum-cubes n)
  (sum cube 0 inc n))

(sum-integers 4)
(sum-squares 4)
(sum-cubes 4)