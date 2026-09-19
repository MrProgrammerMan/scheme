#lang sicp

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval-old x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (mul-interval x y)
  (let ((lx (lower-bound x))
        (ux (upper-bound x))
        (ly (lower-bound y))
        (uy (upper-bound y)))
    (if (positive? lx)
        (if (positive? ly)
            (make-interval (* lx ly) (* ux uy))
            (if (positive? uy)
                (make-interval (* ux ly) (* ux uy))
                (make-interval (* ux ly) (* lx uy))))
        (if (positive? ux)
            (if (positive? ly)
                (make-interval (* lx uy) (* ux uy))
                (if (positive? uy)
                    (let ((p1 (* lx ly))
                          (p2 (* lx uy))
                          (p3 (* ux ly))
                          (p4 (* ux uy)))
                      (make-interval (min p1 p2 p3 p4)
                                     (max p1 p2 p3 p4)))
                    (make-interval (* ux ly) (* lx ly))))
            (if (positive? ly)
                (make-interval (* lx uy) (* ux ly))
                (if (positive? uy)
                    (make-interval (* lx uy) (* lx ly))
                    (make-interval (* ux uy) (* lx ly))))))))

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

(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

;; ============================================================
;; Test helper
;; ============================================================

(define (test-mul name x y)
  (newline)
  (display name)
  (newline)
  (display "x = ")
  (print-interval x)
  (display "\ny = ")
  (print-interval y)

  (display "\nold = ")
  (print-interval (mul-interval-old x y))

  (display "\nnew = ")
  (print-interval (mul-interval x y)))


;; ============================================================
;; 1. Both intervals entirely positive
;; ============================================================

(test-mul
 "1. positive * positive"
 (make-interval 2 5)
 (make-interval 10 20))


;; ============================================================
;; 2. x positive, y spans zero on the negative-to-positive side
;; ============================================================

(test-mul
 "2. positive * (-,+)"
 (make-interval 2 5)
 (make-interval -10 20))


;; ============================================================
;; 3. x positive, y entirely negative
;; ============================================================

(test-mul
 "3. positive * negative"
 (make-interval 2 5)
 (make-interval -20 -10))


;; ============================================================
;; 4. x spans zero, y entirely positive
;; ============================================================

(test-mul
 "4. (-,+) * positive"
 (make-interval -5 3)
 (make-interval 10 20))


;; ============================================================
;; 5. Both intervals span zero
;; ============================================================

(test-mul
 "5. (-,+) * (-,+)"
 (make-interval -5 3)
 (make-interval -10 20))


;; ============================================================
;; 6. x spans zero, y entirely negative
;; ============================================================

(test-mul
 "6. (-,+) * negative"
 (make-interval -5 3)
 (make-interval -20 -10))


;; ============================================================
;; 7. x entirely negative, y entirely positive
;; ============================================================

(test-mul
 "7. negative * positive"
 (make-interval -5 -2)
 (make-interval 10 20))


;; ============================================================
;; 8. x entirely negative, y spans zero
;; ============================================================

(test-mul
 "8. negative * (-,+)"
 (make-interval -5 -2)
 (make-interval -10 20))


;; ============================================================
;; 9. Both intervals entirely negative
;; ============================================================

(test-mul
 "9. negative * negative"
 (make-interval -5 -2)
 (make-interval -20 -10))


;; ============================================================
;; 10. Zero as a boundary
;; ============================================================

(test-mul
 "10. zero boundary * positive"
 (make-interval 0 5)
 (make-interval 10 20))


;; ============================================================
;; 11. Zero as the upper boundary
;; ============================================================

(test-mul
 "11. negative * zero boundary"
 (make-interval -5 -2)
 (make-interval -10 0))


;; ============================================================
;; 12. Exact zero interval
;; ============================================================

(test-mul
 "12. zero * anything"
 (make-interval 0 0)
 (make-interval -10 20))