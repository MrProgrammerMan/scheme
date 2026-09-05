;; Oppgave 1
;;   f.
(car (cdr '(0 42 #t bar)))
;;   g.
(car (cdr (car '((0 42) (#t bar)))))
;;   h.
(car (car (cdr '((0) (42 #t) (bar)))))
;;   i.
;;      Listen ((0 42) (#t bar)) kan konstrueres:
;;        - bare ved bruk av cons:
(cons
 (cons 0 (cons 42 '()))
 (cons (cons #t (cons 'bar '())) '()))
;;        - bare ved bruk av list:
(list (list 0 42) (list #t 'bar))
;; Oppgave 2
;;   a.
(define (my-reverse ls)
  (define (iter in out)
    (if (null? in)
        out
        (iter (cdr in) (cons (car in) out))))
  (iter ls '()))

(my-reverse '(a b c d e f))
(my-reverse '(a b))
(my-reverse '())