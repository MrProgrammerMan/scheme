#lang sicp

;; the current value of a node: first non-pair after the key, or #f
(define (node-value node)
  (define (find rest)
    (cond ((null? rest) #f)
          ((pair? (car rest)) (find (cdr rest)))
          (else (car rest))))
  (find (cdr node)))

;; the child nodes of a node: the pairs after the key
(define (node-children node)
  (define (find rest)
    (cond ((null? rest) '())
          ((pair? (car rest)) (cons (car rest) (find (cdr rest))))
          (else (find (cdr rest)))))
  (find (cdr node)))

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (define (iter keys node)
        (if (null? keys)
            (node-value node)
            (let ((child (assoc (car keys) (cdr node))))
              (and child (iter (cdr keys) child)))))
      (iter keys local-table))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((not (pair? (car records))) (assoc key (cdr records)))  ; skip values
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (insert! keys value)
      (define (iter keys table)
        (if (null? keys)
            (begin
              (set-cdr! table
                        (cons value (cdr table))))
            (let ((subtable
                   (assoc (car keys) (cdr table))))
              (if subtable
                  (iter (cdr keys) subtable)
                  (begin
                    (set-cdr! table (cons (list (car keys))
                                          (cdr table)))
                    (iter (cdr keys) (cadr table)))))))
      (iter keys local-table))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'inner-table) local-table)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define (print-table table)
  (define (indent n)
    (if (> n 0)
        (begin (display "  ")
               (indent (- n 1)))))
  (define (print-node node depth)
    (indent depth)
    (display (car node))
    (let ((v (node-value node)))
      (if v
          (begin (display " -> ")
                 (display v))))
    (newline)
    (for-each (lambda (child) (print-node child (+ depth 1)))
              (reverse (node-children node))))
  (display "*table*")
  (newline)
  (for-each (lambda (child) (print-node child 1))
            (reverse (node-children (table 'inner-table)))))

(define operation-table (make-table eq?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put '(0 0) '+)
(put '(0 1) '-)
(put '(2 0) 'and)
(put '(0 2 3) 'or)
(put '(0 2 4) 'xor)
(put '(0 2) 'well)
(put '(0 2 3) 'orc)

(print-table operation-table)