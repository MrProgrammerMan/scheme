(define (square x) (* x x))

(define (tree-map f t)
  (map (lambda (sub-tree)
         (cond ((null? sub-tree) '())
               ((pair? sub-tree) (tree-map f sub-tree))
               (else (f sub-tree))))
       t))

(define (square-tree t) (tree-map square t))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))