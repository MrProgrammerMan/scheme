#lang sicp

(define f
  (let ((state 0))
    (lambda (x)
      (if (= state x)
          (begin
            (set! state 100)
            state)
          state))))

;; 1.00
(+ (f 1) (f 0))

;; 200
(+ (f 0) (f 1))