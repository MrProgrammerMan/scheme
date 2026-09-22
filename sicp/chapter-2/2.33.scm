(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map-alt p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (square x) (* x x))
(map-alt square '(1 2 3 4))

(define (append-alt seq1 seq2)
  (accumulate cons seq2 seq1))

(append-alt '(1 2 3) '(4 5 6))

(define (length-alt sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

(length-alt '(1 2 3 4 5 6 5 5 5))