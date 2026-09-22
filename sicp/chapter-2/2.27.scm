(define (reverse-l l)
  (if (null? l)
      l
      (append (reverse-l (cdr l)) (cons (car l) '()))))

(define (reverse-iter l)
  (define (iter in out)
    (if (null? in)
        out
        (iter (cdr in) (cons (car in) out))))
  (iter l '()))

(reverse-l (list 1 2 3 4 5))
(reverse-iter (list 1 2 3 4 5))

(define (reverse-rec l)
  (if (null? l)
      '()
      (append (reverse (cdr l)) (list (car l)))))

(define (reverse-deep l)
  (map reverse-rec (reverse-rec l)))

(reverse-deep '((1 2) (3 4)))