#lang sicp

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record (cdr record) #f))
            #f)))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1 (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'inner-table) local-table)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define (print-table table)
  (define (print-record record)
    (display "    ")
    (display (car record))
    (display " -> ")
    (display (cdr record))
    (newline))
  (define (print-subtable subtable)
    (display "  ")
    (display (car subtable))        ; key-1
    (newline)
    (for-each print-record
              (reverse (cdr subtable))))  ; records for key-2
  (display "*table*")
  (newline)
  (for-each print-subtable
            (reverse (cdr (table 'inner-table)))))

(define operation-table (make-table =))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 0 0 '+)
(put 0 1 '-)
(put 2 0 'and)

(print-table operation-table)