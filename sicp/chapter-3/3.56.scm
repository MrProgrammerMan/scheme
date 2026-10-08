#lang sicp
(#%require "stream-primitives.scm")

(define (merge-two s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge-two (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge-two s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

(define (merge s0 . rest)
  (if (stream-null? rest)
      s0
      (apply merge (cons (merge-two s0 (car rest))
                         (cdr rest)))))

(define (scale-stream s n)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (* n (stream-car s))
                   (scale-stream (stream-cdr s) n))))

(define S
  (cons-stream 1
               (merge
                (scale-stream S 2)
                (scale-stream S 3)
                (scale-stream S 5))))

(take 20 S)