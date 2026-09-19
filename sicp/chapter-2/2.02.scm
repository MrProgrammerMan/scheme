(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (midpoint-segment s)
  (average-points (start-segment s) (end-segment s)))

(define (average-points p1 p2)
  (make-point
   (average (x-point p1) (x-point p2))
   (average (y-point p1) (y-point p2))))

(define (average x y) (/ (+ x y) 2))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define a (make-point  3.0 8.0))
(define b (make-point -4.0 1.0))
(define c (make-point 15.0 0.0))
(define d (make-point  2.0 2.0))

(print-point (midpoint-segment (make-segment a b)))
(print-point (midpoint-segment (make-segment a c)))
(print-point (midpoint-segment (make-segment b c)))
(print-point (midpoint-segment (make-segment c d)))