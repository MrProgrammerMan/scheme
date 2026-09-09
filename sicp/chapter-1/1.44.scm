(define (repeated f n)
  (if (= n 1)
      f
      (lambda (x) (f ((repeated f (- n 1)) x)))))

(define (average3 a b c)
  (/ (+ a b c) 3))

(define (smooth f)
  (lambda (x) (average3
               (f x)
               (f (+ x 1))
               (f (- x 1)))))

(define (square x) (* x x))

((smooth square) 5)

(define (identity x) x)
((smooth identity) 10)

(define (inc x) (+ x 1))

((smooth inc) 3)

(((repeated smooth 3) square) 5)