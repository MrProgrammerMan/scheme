(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (+ a 1) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (identity x) x)
(define (square x) (* x x))

(define (inc x) (+ x 1))

(define (sum-squares n)
  (sum square 1 inc n))

(define (factorial n)
  (product identity 1 inc n))

(sum-squares 4)
(sum-squares 5)
(factorial 4)
(factorial 5)

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (combiner (term a) result))))
  (iter a null-value))

(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (sum-squares-iter n)
  (sum-iter square 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(sum-squares-iter 4)
(sum-squares-iter 5)
(factorial-iter 4)
(factorial-iter 5)