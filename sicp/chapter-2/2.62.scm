#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((> x (car set)) #f)
        ((= x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((> x (car set))
         (cons (car set) (adjoin-set x (cdr set))))
        ((< x (car set)) (cons x set))
        (else set)))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((< (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        ((< (car set2) (car set1))
         (cons (car set2) (union-set set1 (cdr set2))))
        (else (cons (car set1) (union-set (cdr set1) (cdr set2))))))

; Basic union
(union-set '(1 3 5) '(2 4 6))
; => (1 2 3 4 5 6)

; Overlapping elements
(union-set '(1 3 5) '(3 5 7))
; => (1 3 5 7)

; One set contained in the other
(union-set '(1 2 3 4) '(2 3))
; => (1 2 3 4)

; Sets with no overlap
(union-set '(1 2 3) '(7 8 9))
; => (1 2 3 7 8 9)

; Identical sets
(union-set '(1 2 3) '(1 2 3))
; => (1 2 3)

; Empty first set
(union-set '() '(1 2 3))
; => (1 2 3)

; Empty second set
(union-set '(1 2 3) '())
; => (1 2 3)

; Both empty
(union-set '() '())
; => ()

; Multiple overlaps in different positions
(union-set '(1 4 7 10) '(2 4 6 10 12))
; => (1 2 4 6 7 10 12)

; Single elements
(union-set '(3) '(5))
; => (3 5)

(union-set '(3) '(3))
; => (3)