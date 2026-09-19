(define (for-each-do f l)
  (cond ((pair? l)
         (f (car l))
         (for-each-do f (cdr l)))))

(for-each-do (lambda (x) (newline) (display x))
             (list 57 321 88))