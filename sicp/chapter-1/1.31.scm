(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (* result (term a)))))
  (iter a 1))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(factorial-iter 1)
(factorial-iter 2)
(factorial-iter 3)
(factorial-iter 4)
(factorial-iter 5)

(define (pi-fourth-term a)
  (define (numer a)
    (if (even? a)
        (+ a 2)
        (+ a 1)))
  (define (denom a)
    (if (odd? a)
        (+ a 2)
        (+ a 1)))
  (/ (numer a) (denom a)))

(define (estimate-pi-iter n)
  (* 4.0 (product-iter pi-fourth-term 1 inc n)))

(estimate-pi-iter 10000)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (+ a 1) next b))))

(define (factorial n)
  (product identity 1 inc n))

(define (estimate-pi n)
  (* 4.0 (product pi-fourth-term 1 inc n)))

(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)

(estimate-pi-iter 10000)