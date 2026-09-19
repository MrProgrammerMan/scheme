;; cons
(define (make-pair a b) (* (expt 2 a) (expt 3 b)))

;; car
(define (fst p)
  (if (= (gcd p 3) 1)
      (log2 p)
      (fst (/ p 3))))

;; cdr
(define (snd p)
  (if (= (gcd p 2) 1)
      (log3 p)
      (snd (/ p 2))))

;; Helpers
(define (logn n)
  (lambda (x) (/ (log x) (log n))))
(define log2 (logn 2))
(define log3 (logn 3))

;; Calls
(define p (make-pair 3 7))
(fst p)
(snd p)