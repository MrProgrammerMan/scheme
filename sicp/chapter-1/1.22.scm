#lang sicp

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

(display "searching for closest primes over 1'000")
(search-for-primes 1000 1019)
(display "searching for closest primes over 10'000")
(search-for-primes 10000 10037)
(display "searching for closest primes over 100'000")
(search-for-primes 100000 100043)
(display "searching for closest primes over 1'000'000")
(search-for-primes 1000000 1000037)
(display "searching for closest primes over 10'000'000")
(search-for-primes 10000000 10000103)
(display "searching for closest primes over 100'000'000")
(search-for-primes 100000000 100000039)
(display "searching for closest primes over 1'000'000'000")
(search-for-primes 1000000000 1000000021)