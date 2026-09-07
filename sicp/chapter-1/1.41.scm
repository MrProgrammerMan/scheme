(define (inc x) (+ x 1))
(define (inc-applied-2-times x) (inc (inc x)))
(define (inc-applied-4-times x) (inc (inc (inc (inc x)))))
(define (inc-applied-8-times x) (inc (inc (inc (inc (inc (inc (inc (inc x)))))))))
(define (inc-applied-16-times x) (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc x)))))))))))))))))


(define (double f) (lambda (x) (f (f x))))

(((double (double double)) inc) 5)

; Step 1: expand the inner (double double)
;   double double = apply-f-4-times
; (((double (lambda (f) (double (double f))))) inc) 5)

; Step 2: expand the outer double, which composes that operator with itself
;   result = apply-f-16-times
(((lambda (f) ((lambda (f2) (double (double f2)))
                 ((lambda (f2) (double (double f2))) f)))
    inc)
   5)

; Step 3: substitute f = inc, simplify repeated doubling
((double (double (double (double inc)))) 5)

; Step 4: each "double" halves the doubling count, unwind outward-in
((double (double (double inc-applied-2-times)))       5)
((double (double inc-applied-4-times))                5)
((double inc-applied-8-times)                         5)
(inc-applied-16-times                                 5)

; Step 5: apply inc 16 times to 5
(+ 5 16)
; = 21