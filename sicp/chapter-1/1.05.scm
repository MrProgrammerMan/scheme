(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;; In applicative order evaluation, the value of the arguments are evaluated first.
;; In this case, evaluation of (p) will hang.
;; In normal order (lazy) evaluation, test is substituted first.
;; When if is evaluated, test returns 0 without evaluating (p) first.

;; (define p (p)) is invalid: the right-hand side (p) is evaluated immediately,
;; calling p before p is bound to anything -- unbound variable error.
;; (define (p) (p)) works instead because it's sugar for
;; (define p (lambda () (p))): the lambda defers evaluation of its body,
;; so p is fully bound before (p) is ever called.