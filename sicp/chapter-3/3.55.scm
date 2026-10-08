#lang sicp
(#%require "stream-primitives.scm")

(define (partial-sums s)
 (define sums
   (cons-stream (stream-car s)
                (add-streams (stream-cdr s) sums)))
  sums)

(define (add-streams s1 s2)
  (if (or (stream-null? s1) (stream-null? s2))
      the-empty-stream
      (cons-stream (+ (stream-car s1) (stream-car s2))
                   (add-streams (stream-cdr s1) (stream-cdr s2)))))

(take 5 (partial-sums integers))