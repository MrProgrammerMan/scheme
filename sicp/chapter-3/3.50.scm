#lang sicp

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (integers-stream n)
  (cons-stream n (integers-stream (+ 1 n))))

(define integers (integers-stream 1))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

(define (take n stream)
  (if (= n 0)
      '()
      (cons (stream-car stream) (take (- n 1) (stream-cdr stream)))))

(define (primes-stream seed)
  (let ((fst (stream-car seed))) ; Take out the first number, prime by definition
    (cons-stream fst
                 (primes-stream ; Recurse
                  (stream-filter ; Filter the rest of the seed-stream
                   (lambda (item) (= 1 (gcd item fst))) ; And remove elements that are multiples of the selected number
                   (stream-cdr seed))))))

(define primes (primes-stream (stream-cdr integers)))

(take 10 primes)

(define (stream-map proc . argstreams)
  (if (equal? the-empty-stream (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define double-primes (stream-map + primes primes))

(take 5 double-primes)

(define double-primes-plus-n (stream-map + primes primes integers))

(take 5 double-primes-plus-n)