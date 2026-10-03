#lang sicp

(define f
  (let ((trigger 1) (out 0))
    (lambda (x)
      (if (= trigger x)
          (let ((old out))
            (begin
              (set! out 1)
              old))
          0))))

;; 0
(+ (f 0) (f 1))

;; 1
(+ (f 1) (f 0))