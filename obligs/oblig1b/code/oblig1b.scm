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
  (define (my-reverse-iter in out)
    (if (null? in)
        out
        (my-reverse-iter (cdr in) (cons (car in) out))))
  (my-reverse-iter ls '()))

(my-reverse '(a b c d e f))
(my-reverse '(a b))
(my-reverse '())
;;   b.
(define (take n items)
  (if (or (= n 0) (null? items))
      '()
      (cons (car items) (take (- n 1) (cdr items)))))
(take 3 '(a b c d e f))
;;   c. Akkumuler de relevante verdiene baklengs, og reverser resultatet tilbake.
(define (take-iter n items)
  (define (iter n in out)
    (if (or (= n 0) (null? in))
        out
        (iter (- n 1) (cdr in) (cons (car in) out))))
  (my-reverse (iter n items '())))
(take-iter 3 '(a b c d e f))
;;   d.
(define (take-while pred items)
  (if (null? items)
      '()
      (let ((fst (car items)))
        (if (pred fst)
            (cons fst (take-while pred (cdr items)))
            '()))))
(take-while odd? '(1 3 1 5 9 13 2 9 1 3 5 5 6 7))
(take-while (lambda (x) (< x 5)) '(1 3 1 5 9 13 2 9 1 3 5 5 6 7))
;;   e.
(define (map2 proc l r)
  (if (or (null? l) (null? r))
      '()
      (cons (proc (car l) (car r)) (map2 proc (cdr l) (cdr r)))))
(map2 +
      '(1 4 2 3 1  -6  9)
      '(1 1 1 2 2  -5 -1 1 1 12 -15))
;;    =(2 5 3 5 3 -11  8)
(map2 (lambda (x y) (/ (+ x y) 2))
      '(1 5 2.0 3.0 1 -6.0  9)
      '(1 1 1.0 2.0 3 -5.0 -1 1 1 12 -15))
;;    =(1 3 1.5 2.5 2 -5.5  4)