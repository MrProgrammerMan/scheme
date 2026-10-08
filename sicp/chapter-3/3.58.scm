#lang sicp
(#%require "stream-primitives.scm")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(take 10 (expand 1 7 10))
(take 10 (expand 3 8 10))

; Long division!!