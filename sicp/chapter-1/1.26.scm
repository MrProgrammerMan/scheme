;; By rewriting the expmod-method
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m ))
                    m))))
;; instead of
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m ))
                    m))))
;; the argument (expmod base (/ exp 2) m) is evaluated twice for every supposed halving of the steps required to calculate the result.
;; Therefore, the whole point for successive squaring is undone, and the procedure is of the same time complexity as a "naive" multiplying exponenciation.