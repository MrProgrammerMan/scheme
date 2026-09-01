(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* a b)))))

(define (fast-expt-rec b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-rec b (/ n 2))))
        (else (* b (fast-expt-rec b (- n 1))))))

(define (square x) (* x x))

(fast-expt-rec 10 12)
(fast-expt-iter 10 12 1)
(fast-expt-rec 7 29)
(fast-expt-iter 7 29 1)
(fast-expt-rec 85 17)
(fast-expt-iter 85 17 1)