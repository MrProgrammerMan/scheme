#lang sicp

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (equal? the-empty-stream (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define (take n s)
  (if (= n 0)
      the-empty-stream
      (cons (stream-car s) (take (- n 1) (stream-cdr s)))))

(define s (cons-stream 1 (add-streams s s)))
; Each element is double the last, starting with 1
(take 5 s)