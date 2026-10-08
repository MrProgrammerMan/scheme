#lang sicp
(#%require "stream-primitives.scm")

(define (mul-streams s1 s2)
  (if (or (stream-null? s1) (stream-null? s2))
      the-empty-stream
      (cons-stream (* (stream-car s1)
                      (stream-car s2))
                   (mul-streams (stream-cdr s1)
                               (stream-cdr s2)))))

(define factorials (cons-stream 1 (mul-streams factorials (stream-cdr integers))))

(take 10 factorials)