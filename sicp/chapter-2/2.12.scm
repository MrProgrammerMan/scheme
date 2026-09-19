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

;; ============================================================
;; Test 1
;; Same interval: 8 - 12
;; Center = 10
;; Width  = 2
;; Percent = 20%
;; ============================================================

(define i1
  (make-interval 8 12))

(define i2
  (make-center-width 10 2))

(define i3
  (make-center-percent 10 20))

(newline)
(display "Test 1: 8 - 12")
(newline)
(print-interval i1)
(newline)
(print-interval i2)
(newline)
(print-interval i3)


;; ============================================================
;; Test 2
;; Same interval: 90 - 110
;; Center = 100
;; Width  = 10
;; Percent = 10%
;; ============================================================

(define i4
  (make-interval 90 110))

(define i5
  (make-center-width 100 10))

(define i6
  (make-center-percent 100 10))

(newline)
(display "Test 2: 90 - 110")
(newline)
(print-interval i4)
(newline)
(print-interval i5)
(newline)
(print-interval i6)


;; ============================================================
;; Test 3
;; Same interval: 45 - 55
;; Center = 50
;; Width  = 5
;; Percent = 10%
;; ============================================================

(define i7
  (make-interval 45 55))

(define i8
  (make-center-width 50 5))

(define i9
  (make-center-percent 50 10))

(newline)
(display "Test 3: 45 - 55")
(newline)
(print-interval i7)
(newline)
(print-interval i8)
(newline)
(print-interval i9)


;; ============================================================
;; Test 4
;; Same interval: 18 - 22
;; Center = 20
;; Width  = 2
;; Percent = 10%
;; ============================================================

(define i10
  (make-interval 18 22))

(define i11
  (make-center-width 20 2))

(define i12
  (make-center-percent 20 10))

(newline)
(display "Test 4: 18 - 22")
(newline)
(print-interval i10)
(newline)
(print-interval i11)
(newline)
(print-interval i12)

(define x (make-interval 90 110))
(define y (make-center-width (center x) (width x)))
(define z (make-center-percent (center x) (* (percent x) 100)))

(newline)
(display "Original: ")
(print-interval x)

(newline)
(display "From center/width: ")
(print-interval y)

(newline)
(display "From center/percent: ")
(print-interval z)

(newline)
(display "Center: ")
(display (center x))

(newline)
(display "Width: ")
(display (width x))

(newline)
(display "Percent: ")
(display (* (percent x) 100))
(display "%")