#lang sicp

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

(define (spans-zero i)
  (or
   (< (* (lower-bound i) (upper-bound i)) 0)
   (= (lower-bound i) 0)
   (= (upper-bound i) 0)))

(define (div-interval x y)
  (if (spans-zero y)
      (error "Cannot divide by interval containing 0")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (make-interval a b) (cons a b))

;; For testing
(define (print-interval i)
  (newline)
  (display (lower-bound i))
  (display " - ")
  (display (upper-bound i)))

(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define a (make-interval -5 3.8))
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
(print-interval (div-interval a b))
(newline)
;; Fails
(print-interval (div-interval b a))
(define c (make-interval 0 10))
;; Fails
(print-interval (div-interval a c))