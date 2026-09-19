(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount
                     (except-first-denomination coin-values))
                 (cc (- amount
                        (first-denomination coin-values))
                     coin-values)))))

(define (first-denomination coin-values) (car coin-values))
(define (except-first-denomination coin-values) (cdr coin-values))
(define (no-more? coin-values) (null? coin-values))

(define us-coins (list 25 10 50 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(cc 80 us-coins)
(cc 80 uk-coins)

(define one-coin (list 30))

(cc 30 one-coin)
(cc 100 one-coin)

;; The order of the coins don't matter.
;; The algorithm generates a tree-recursive process that tries to count to the target value using any possible combination of coins from the coin set.