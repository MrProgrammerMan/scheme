(define (square-list-1 items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list-1 (cdr items)))))

(define (square x) (* x x))

(define (square-list-2 items)
  (map square items))

(define l '(1 2 3 4 5))

(square-list-1 l)
(square-list-2 l)