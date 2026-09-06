#lang sicp

(define (expmod base exp m)
  (remainder (fast-expt-iter base exp 1) m))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* a b)))))

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

(timed-prime-test 10007)
(display "The new definition of expmod is horribly slow:")
(newline)
(timed-prime-test-fast 10007)
(display "
  Recursively, the old version expands to something like (remainder (square (remainder (* base (remainder ....
  This means that we are constantly squishing our value down to be less than m.
  We are preventing having square and multiply a redicoulously large number just to remove copies of m at the end.
  Instead, we remove those copies underway.
")
(newline)