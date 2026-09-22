(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets '(1 2 3))

;; The subsets are all subsets of the set with an element removed,
;; along with all sets where those subsets have the element added back in.