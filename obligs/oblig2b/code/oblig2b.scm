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

;;    b.
(newline)
(display "2b.")
(newline)

(define (pop! s) (s 'pop!))
(define (stack s) (s 'stack))
(define (push! s . items) (apply s (cons 'push! items)))

;; Test-kall:
(pop! s1)
(stack s1)
(push! s1 'foo 'faa)
(stack s1)


;; 3.
;;    c.
(newline)
(display "3c.")
(newline)

(define (cycle? l)
  ;; "Floyd's tortoise and hare":
  (define (race slow fast)
    (cond ((or (null? fast) (null? (cdr fast))) #f) ; Ingen syklus hvis listen tar slutt
          ((eq? slow fast) #t) ; Pekerne møtes
          (else (race (cdr slow) (cddr fast)))))
  (if (null? l)
      #f
      (race l (cdr l))))

;; Test-kall:
(define bar (list 'a 'b 'c 'd 'e))
(set-cdr! (cdddr bar) (cdr bar))
(define bah (list 'bring 'a 'towel))
(set-car! bah (cdr bah))
(set-car! (car bah) 42)
(cycle? '(hey ho))
(cycle? '(la la la))
(cycle? bah)
(cycle? bar)