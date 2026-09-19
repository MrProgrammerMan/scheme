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

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (spans-zero i)
  (or
   (< (* (lower-bound i) (upper-bound i)) 0)
   (= (lower-bound i) 0)
   (= (upper-bound i) 0)))

(define (make-interval a b) (cons a b))

;; For testing
(define (print-interval i)
  (display (lower-bound i))
  (display " - ")
  (display (upper-bound i)))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (make-center-percent c p)
  (let ((w (* c (/ p 100))))
    (make-center-width c w)))

(define (percent i)
  (/ (width i) (center i)))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define a (make-center-percent 12 1))
(define b (make-center-percent 28 1))

(print-interval (par1 a b))
(newline)
(print-interval (par2 a b))
(newline)

(define div1 (div-interval a a))
(print-interval div1)
(newline)
(center div1)
(percent div1)

(define div2 (div-interval a b))
(print-interval div2)
(newline)
(center div2)
(percent div2)

;; With 0 error (interval of width 0), par1 and par2 produce equal results.
;; It is the uncertainty that shifts the result for every primitive interval operation performed.