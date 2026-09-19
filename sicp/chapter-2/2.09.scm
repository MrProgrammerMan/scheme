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

(define (sub-interval x y)
  (let ((p1 (- (lower-bound x) (lower-bound y)))
        (p2 (- (lower-bound x) (upper-bound y)))
        (p3 (- (upper-bound x) (lower-bound y)))
        (p4 (- (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(print-interval a)
(print-interval b)
(print-interval (sub-interval a b))
(print-interval (sub-interval b a))

;; For an interval, the width can be defines as such:
(define (width-interval x)
  (abs (/ (- (lower-bound x) (upper-bound x)) 2)))

(newline)
(width-interval a)
(width-interval b)

;; We can use equational reasoning to what the width of an interval sum computes to:
(width-interval (add-interval a b))
(width-interval
 (make-interval
  (+ (lower-bound a) (lower-bound b))
  (+ (upper-bound a) (upper-bound b))))
(abs (/ (-
         (lower-bound
          (make-interval
           (+ (lower-bound a) (lower-bound b))
           (+ (upper-bound a) (upper-bound b))))
         (upper-bound
          (make-interval
           (+ (lower-bound a) (lower-bound b))
           (+ (upper-bound a) (upper-bound b))))
         )
        2))
(abs (/ (-
         (+ (lower-bound a) (lower-bound b))
         (+ (upper-bound a) (upper-bound b))
         )
        2))

;; Regroup the subtraction: (la + lb) - (ua + ub) = (la - ua) + (lb - ub)
(abs (/ (+ (- (lower-bound a) (upper-bound a))
           (- (lower-bound b) (upper-bound b)))
        2))

;; Split the fraction: (x + y)/2 = x/2 + y/2
(abs (+ (/ (- (lower-bound a) (upper-bound a)) 2)
        (/ (- (lower-bound b) (upper-bound b)) 2)))

;; Each term is negative or zero (lower <= upper), so both terms share a sign.
;; Because they share a sign, |x + y| = |x| + |y|:
(+ (abs (/ (- (lower-bound a) (upper-bound a)) 2))
   (abs (/ (- (lower-bound b) (upper-bound b)) 2)))

;; Each term is exactly the definition of width-interval:
(+ (width-interval a) (width-interval b))

;; For multiplying intervals, the width is not a function purely of the widths:
(width-interval (mul-interval a b))
;; c has the same width as a
(define c (make-interval 23.2 23.8))
;; Yet the width of c*b is different from that of a*b
(width-interval (mul-interval c b))