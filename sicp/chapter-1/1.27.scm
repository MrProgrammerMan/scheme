#lang sicp

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m ))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n test-value)
  (= (expmod test-value n n) test-value))

(define (fermat-prime? n test-value)
  (cond ((= test-value n) true)
        ((fermat-test n test-value) (fermat-prime? n (+ test-value 1)))
        (else false)))

(define (timed-prime-test-fermat n)
  (start-prime-test-fermat n (runtime)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))

(define (start-prime-test-fermat n start-time)
  (if (fermat-prime? n 2)
      (report-prime n (- (runtime) start-time))))

(define (report-prime prime elapsed-time)
  (newline)
  (display prime)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (define (search start end)
    (if (> start end)
        'done
        (begin
          (timed-prime-test start)
          (search (+ 2 start) end))))
  (search (if (even? start) (+ start 1) start) end))

(define (search-for-primes-fermat start end)
  (define (search start end)
    (if (> start end)
        'done
        (begin
          (timed-prime-test-fermat start)
          (search (+ 2 start) end))))
  (search (if (even? start) (+ start 1) start) end))

(timed-prime-test 10007)
(timed-prime-test-fermat 10007)
(timed-prime-test 10037)
(timed-prime-test-fermat 10037)
(timed-prime-test 10039)
(timed-prime-test-fermat 10039)
(newline)
(display "The fermat test is fooled by the carmichael numbers")
(newline)
(prime? 561)
(prime? 1105)
(prime? 1729)
(prime? 2465)
(prime? 2821)
(prime? 6601)
(display "Fermat:")
(newline)
(fermat-prime? 561 2)
(fermat-prime? 1105 2)
(fermat-prime? 1729 2)
(fermat-prime? 2465 2)
(fermat-prime? 2821 2)
(fermat-prime? 6601 2)