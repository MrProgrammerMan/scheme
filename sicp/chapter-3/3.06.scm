#lang sicp

(define (rand-update x)
  (let ((a 1664525)
        (c 1013904223)
        (m 4294967296))   ; 2^32
    (remainder (+ (* a x) c) m)))

(define rand
  (let ((count 1))
    (define generate
      (lambda ()
        (set! count (rand-update count))
        count))
    (define reset
      (lambda (new-val)
        (set! count new-val)
        'reset))
    (define dispatch
      (lambda (op)
        (cond ((eq? op 'generate) (generate))
              ((eq? op 'reset) reset)
              (else (error "Unknown op -- RAND" op)))))
    dispatch))

(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 1)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)