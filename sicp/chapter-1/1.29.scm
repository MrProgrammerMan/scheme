(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (weighted-y k)
    (cond ((or (= k 0) (= k n)) (y k))
          ((even? k) (* 2 (y k)))
          (else (* 4 (y k)))))
  (define (sum total k)
    (if (> k n) total
        (sum
         (+ total (weighted-y k))
         (+ k 1))))
  (if (odd? n)
      (error-n-must-be-even) ;; A bit crude
      (* (/ h 3.0) (sum 0.0 0))))

(define (cube x) (* x x x))
(integral cube 0.0 1.0 100)