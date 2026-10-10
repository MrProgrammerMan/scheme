;; 1.
;;    a.
(display "1a")
(newline)
(define (make-counter)
  (let ((count 0))
    (lambda ()
      (set! count (+ count 1))
      count)))

;; Test-kall:
(define count 42)
(define c1 (make-counter))
(define c2 (make-counter))
(c1)
(c1)
(c1)
(display count)
(newline)
(c2)

;; 2.
;;    a.
(newline)
(display "2a.")
(newline)

(define (make-stack items)
  (let ((inner-list items))
    (define (pop)
      (if (not (null? inner-list))
          (set! inner-list (cdr inner-list))))
    (define (push items)
      (if (not (null? items))
          (begin
            (set! inner-list (cons (car items) inner-list))
            (push (cdr items)))))
    (define (dispatch m . args)
      (cond ((eq? m 'pop!) (pop))
            ((eq? m 'push!) (push args))
            ((eq? m 'stack) inner-list)
            (else "unsupported operation -- MAKE-STACK")))
    dispatch))

;; Test-kall:
(define s1 (make-stack (list 'foo 'bar)))
(define s2 (make-stack '()))
(s1 'pop!)
(s1 'stack)
(s2 'pop!)
(s2 'push! 1 2 3 4)
(s2 'stack)
(s1 'push! 'bah)
(s1 'push! 'zap 'zip 'baz)
(s1 'stack)