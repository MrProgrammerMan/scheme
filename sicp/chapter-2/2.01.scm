(define (xor a b)
  (if a (not b) b))

(define (make-rat n d)
  (let ((g (gcd n d))
        (sign (if (xor (positive? n) (positive? d))
                       -1
                       1)))
    (cons (* sign (abs (/ n g))) (abs (/ d g)))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 4 -5))
(print-rat (make-rat 10 -50))