;; Needed for excercises
(define (inc x) (+ x 1))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))
;;;;;;

(define (filtered-accumulate combiner null-value term a next b filter)
  (cond ((> a b)null-value)
        ((filter a)
         (combiner
          (term a)
          (filtered-accumulate combiner null-value term (+ a 1) next b filter)))
        (else (filtered-accumulate combiner null-value term (+ a 1) next b filter))))



;; a.
(define (sum-of-squares-of-primes-in-interval a b)
  (filtered-accumulate + 0 square a inc b prime?))

(sum-of-squares-of-primes-in-interval 2 2)
(sum-of-squares-of-primes-in-interval 2 3)
(sum-of-squares-of-primes-in-interval 2 5)
(sum-of-squares-of-primes-in-interval 2 7)
(sum-of-squares-of-primes-in-interval 2 11)

;; b.
(define (product-of-positive-integers-relatively-prime-to n)
  (filtered-accumulate *
                       1
                       (lambda (x) x)
                       2
                       inc
                       (- n 1)
                       (lambda (i)
                         (= 1 (gcd i n)))))

(product-of-positive-integers-relatively-prime-to 3) ;; 2
(product-of-positive-integers-relatively-prime-to 4) ;; 3
(product-of-positive-integers-relatively-prime-to 5) ;; 2*3*4=24
(product-of-positive-integers-relatively-prime-to 6) ;; 5
(product-of-positive-integers-relatively-prime-to 7) ;; 2*3*4*5*6=720
(product-of-positive-integers-relatively-prime-to 8) ;; 3*5*7=105