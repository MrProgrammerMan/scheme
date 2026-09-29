(define (equal?-alt a b)
  (or
   (and (symbol? a)
        (symbol?  b)
        (eq? a b))
   (and (null? a)
        (null? b))
   (and (list? a)
        (list? b)
        (equal?-alt (car a) (car b))
        (equal?-alt (cdr a) (cdr b)))))

(equal?-alt '(this is a list) '(this is a list))
(equal?-alt '(this is a list) '(this (is a) list))