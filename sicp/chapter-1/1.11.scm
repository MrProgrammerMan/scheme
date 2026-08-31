(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(f 2)
(f 3)
(f 4)
(f 5)
(f 6)

(define (f-iter n one two three)
  (if (= n 0)
      one
      (f-iter (- n 1) (+ one (* 2 two) (* 3 three)) one two)))

(define (f-i n)
  (if (< n 3)
      n
      (f-iter (- n 2) 2 1 0)))

(f-i 2)
(f-i 3)
(f-i 4)
(f-i 5)
(f-i 6)