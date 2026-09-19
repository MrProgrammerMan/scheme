(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))

;; For testing
(define (print-interval i)
  (newline)
  (display (lower-bound i))
  (display " - ")
  (display (upper-bound i)))

(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define a (make-interval 3.2 3.8))
(define b (make-interval 10.0 11.5))

(print-interval a)
(print-interval b)
(print-interval (add-interval a b))
(print-interval (mul-interval a b))
(print-interval (div-interval a b))
(print-interval (add-interval b a))
(print-interval (mul-interval b a))
(print-interval (div-interval b a))