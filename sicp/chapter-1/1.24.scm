#lang sicp

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m ))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test-fast n)
  (start-prime-test-fast n (runtime)))

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

(define (start-prime-test-fast n start-time)
  (if (fast-prime? n 10)
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

(define (search-for-primes-fast start end)
  (define (search start end)
    (if (> start end)
        'done
        (begin
          (timed-prime-test-fast start)
          (search (+ 2 start) end))))
  (search (if (even? start) (+ start 1) start) end))

(timed-prime-test 1000003)
(timed-prime-test-fast 1000003)
(timed-prime-test 1000033)
(timed-prime-test-fast 1000033)
(timed-prime-test 1000037)
(timed-prime-test-fast 1000037)

(timed-prime-test 10000019)
(timed-prime-test-fast 10000019)
(timed-prime-test 10000079)
(timed-prime-test-fast 10000079)
(timed-prime-test 10000103)
(timed-prime-test-fast 10000103)

(timed-prime-test 100000007)
(timed-prime-test-fast 100000007)
(timed-prime-test 100000037)
(timed-prime-test-fast 100000037)
(timed-prime-test 100000039)
(timed-prime-test-fast 100000039)

(timed-prime-test 1000000007)
(timed-prime-test-fast 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test-fast 1000000009)
(timed-prime-test 1000000021)
(timed-prime-test-fast 1000000021)

(timed-prime-test-fast 63247)
(timed-prime-test-fast 4000000483)

;; Performance is a bit lower than the theoretical logn increase. A squaring of n results in roughly 3x the time.