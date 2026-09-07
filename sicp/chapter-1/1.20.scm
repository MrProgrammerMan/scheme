(define (gcd-iter a b)
  (if (= b 0)
      a
      (gcd-iter b (remainder a b))))

;; Evaluating (gcd 206 40) (implementation of remainder omitted)
;;  In normal-order-evaluation, call by name:
;;     (gcd 206 40) -- b(40) is checked if 0, false, 0 calls to remainder
;;   = (gcd 40 (remainder 206 40)) -- b(6) not 0, false, 1 call to remainder
;;   = (gcd (remainder 206 40) (remainder 40 (remainder 206 40))) -- b(4) not 0, false, 2 calls to remainder
;;   = (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) -- b(2) not 0, false, 4 calls to remainder
;;   = (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) -- b(0) 0, true, 7 calls to remainder
;;   = (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) -- Final calculation is 4 calls to remainder
;;  Eventually reduces down to 2. The number of calls to remainder is 18 in total. 14 is to evaluate b for the if-check, and 4 for the final evaluation.
;;  In normal-order-evaluation, call by need:
;;     (gcd 206 40) -- b(40) is checked if 0, false, 0 calls to remainder
;;   = (gcd 40 (remainder 206 40)) -- b(6) not 0, false, 1 call to remainder
;;   = (gcd 40 6) -- b is cached
;;   = (gcd 6 (remainder 40 6)) -- b(4) not 0, false, 1 call to remainder
;;   = (gcd 6 4) -- b is cached
;;   = (gcd 4 (remainder 6 4)) -- b(2) not 0, false, 1 call to remainder
;;   = (gcd 4 2) -- b is cached
;;   = (gcd 2 (remainder 4 2)) -- b(0) 0, true, 1 call to remainder
;;   = 2
;;  Total: 4 calls
;;  In applicative-order-evaluation, call by value:
;;     (gcd 206 40)
;;   = (gcd 40 (remainder 206 40))
;;   = (gcd 40 6)
;;   = (gcd 6 (remainder 40 6))
;;   = (gcd 6 4)
;;   = (gcd 4 (remainder 6 4))
;;   = (gcd 4 2)
;;   = (gcd 2 (remainder 4 2))
;;   = (gcd 2 0)
;;   = 2
;;  Total: 4 calls