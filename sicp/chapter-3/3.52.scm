#lang sicp

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low (stream-enumerate-interval (+ low 1) high))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-filter pred s)
  (cond ((stream-null? s) the-empty-stream)
        ((pred (stream-car s)) (cons-stream
                                (stream-car s)
                                (stream-filter pred (stream-cdr s))))
        (else (stream-filter pred (stream-cdr s)))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (display x)
  (newline))

(define (take n s)
  (if (= n 0)
      '()
      (cons (stream-car s)
            (take (- n 1) (stream-cdr s)))))

;-------------- Task to examine

(define sum 0)
(display "sum starts out as 0.")
(newline)
(display "Sum: ")
(display sum)
(newline)
(newline)

(define (accum x) (set! sum (+ x sum)) sum)
(define seq ; seq is 1 (1+2) (1+2+3) (1+2+3+4) ...
  (stream-map accum
              (stream-enumerate-interval 1 20)))
(display "seq loads the first item in the stream to be ready.")
(newline)
(display "sum is now 1.")
(newline)
(display "Sum: ")
(display sum)
(newline)
(newline)

(define y (stream-filter even? seq))
(display "The first even element of y is 6.")
(newline)
(display "This corresponds to element 3 of seq.")
(newline)
(display "Accordingly, sum is 6.")
(newline)
(display "Sum: ")
(display sum)
(newline)
(newline)

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
(display "The first element of seq which is divisible by 5 is 10.")
(newline)
(display "Sum is 10")
(newline)
(display "Sum: ")
(display sum)
(newline)
(newline)

(stream-ref y 7)
(display "Getting index 7(pos 8) of y forces eval of y up to 16.")
(newline)
(display "This means seq is loaded to 16.")
(newline)
(display "Sum is 136.")
(newline)
(display "Sum: ")
(display sum)
(newline)
(newline)

(display-stream z)
(newline)

(display "z will run for all numbers divisible by 5,")
(newline)
(display "including the upper bound 20.")
(newline)
(display "Sum is now 210.")
(newline)
(display "Sum: ")
(display sum)
(newline)