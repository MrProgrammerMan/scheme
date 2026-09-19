(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; 1:
;;   (add-1 zero)
;; = (add-1 (lambda (f) (lambda (x) x)))
;; = (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;; = (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;; = (lambda (f) (lambda (x) (f x)))

;; 2:
;;   (add-1 one)
;; = (add-1 (lambda (f) (lambda (x) (f x))))
;; = (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
;; = (lambda (f) (lambda (x) (f (f x))))

;; zero is a curried function (a -> a) -> a -> a which applies the function 0 times to the input and returns its result.
;; one is a function on the same form, which applies the function once to produce the result.
;; So on...

;; Therefore, + must be a function ((a -> a) -> a -> a) -> ((a -> a) -> a -> a) -> ((a -> a) -> a -> a).
;; It takes as arguments to church numerals on the form explained above, and returns a third which is their sum.
;; We can achieve repeated application of the function f the correct number of times by "seeding" a and b with f,
;; then composing the resulting functions and applying to x.

;; In scheme:
(define (add-church a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

;; To test the results of this, we should have a way of converting between church numerals and regular integers.
(define (church-to-int c)
  ((c (lambda (n) (+ n 1))) 0))

(define (int-to-church i)
  (lambda (f) (lambda (x) ((repeat f i) x))))

(define (repeat f n)
  (if (= n 0)
      (lambda (x) x)
      (lambda (x)
        ((repeat f (- n 1)) (f x)))))

(church-to-int zero)
(church-to-int (add-1 zero))
(church-to-int (add-1 (add-1 zero)))

(define one (add-1 zero))
(define two (add-1 one))
(define three (add-1 two))
(define four (add-1 three))
(define five (add-1 four))

(church-to-int five)
(define seven (add-church three four))
(church-to-int seven)

(define twelve (int-to-church 12))
(church-to-int twelve)

(church-to-int (add-church seven twelve))