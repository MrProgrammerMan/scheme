(define (square x) (* x x))

(define (square-tree t)
  (cond ((null? t) '())
        ((pair? t) (cons (square-tree (car t)) (square-tree (cdr t))))
        (else (square t))))

(define (square-tree-map t)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (square sub-tree)))
       t))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(square-tree-map
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))