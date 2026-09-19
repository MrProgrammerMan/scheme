;; Procedures manipulating points
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (average-points p1 p2)
  (make-point
   (average (x-point p1) (x-point p2))
   (average (y-point p1) (y-point p2))))

(define (average x y) (/ (+ x y) 2))

;; Procedures manipulating rectangles, uses only getters
(define (perimeter rect)
  (+ (* 2 (get-width rect))
     (* 2 (get-height rect))))

(define (area rect)
  (* (get-width rect) (get-height rect)))

;; Alternative representations of rectangles:
(define (make-rect-1 center width height) (cons 'r1 (list center width height)))
(define (make-rect-2 p1 p2) (cons 'r2 (cons p1 p2)))
(define (make-rect-3 origin width height) (cons 'r3 (list origin width height)))

;; Wrappers:
(define (get-center rect)
  (case (car rect)
    ((r1) (get-center-1 (cdr rect)))
    ((r2) (get-center-2 (cdr rect)))
    ((r3) (get-center-3 (cdr rect)))))

(define (get-width rect)
  (case (car rect)
    ((r1) (get-width-1 (cdr rect)))
    ((r2) (get-width-2 (cdr rect)))
    ((r3) (get-width-3 (cdr rect)))))

(define (get-height rect)
  (case (car rect)
    ((r1) (get-height-1 (cdr rect)))
    ((r2) (get-height-2 (cdr rect)))
    ((r3) (get-height-3 (cdr rect)))))

;; By center, width and height:
(define (get-center-1 rect) (car rect))
(define (get-width-1 rect) (cadr rect))
(define (get-height-1 rect) (caddr rect))

;; By 2 points:
(define (get-center-2 rect) (average-points (car rect) (cdr rect)))
(define (get-width-2 rect)
  (abs (- (x-point (car rect)) (x-point (cdr rect)))))
(define (get-height-2 rect)
  (abs (- (y-point (car rect)) (y-point (cdr rect)))))

;; By top left origin point, width and height:
(define (get-center-3 rect)
  (make-point
   (+ (x-point (car rect)) (/ (cadr rect) 2))
   (+ (y-point (car rect)) (/ (caddr rect) 2))))
(define (get-width-3 rect) (cadr rect))
(define (get-height-3 rect) (caddr rect))

;; Usage:
(define r1 (make-rect-1 (make-point 3.0 7.0) 10.0 5.0))
(define r2 (make-rect-2 (make-point -2.0 9.5) (make-point 8.0 4.5)))
(define r3 (make-rect-3 (make-point -2.0 9.5) 10.0 5.0))
(newline)
(display (perimeter r1))
(newline)
(display (area r1))
(newline)
(display (perimeter r2))
(newline)
(display (area r2))
(newline)
(display (perimeter r3))
(newline)
(display (area r3))