#lang sicp

(define (make-table)
  (define (make-node tag)
    (let ((value #f)      ; Local data
          (children '())) ; Local data
      (define (set-value! new-value) (set! value new-value))
      (define (add-child! new-child-tag)
        (let ((new (make-node new-child-tag))) ; Create node
          (set! children (cons new children))  ; Add it to children
          new)) ; Return the new node
      (define (get-child tag-to-find) ; Find child of given tag
        (define (iter nodes-to-search tag-to-find)
          (cond ((null? nodes-to-search) #f)
                ((eq? tag-to-find ((car nodes-to-search) 'tag)) (car nodes-to-search))
                (else (iter (cdr nodes-to-search) tag-to-find))))
        (iter children tag-to-find))
      (define (dispatch m)
        (cond ((eq? m 'value) value)
              ((eq? m 'tag) tag)
              ((eq? m 'children) children)
              ((eq? m 'get-child) get-child)
              ((eq? m 'set-value!) set-value!)
              ((eq? m 'add-child!) add-child!)
              (else (error "Unknown op -- NODE" m))))
      dispatch))
  ; Interface to table
  (define (node-value node) (node 'value))
  (define (get-child node child-tag) ((node 'get-child) child-tag))
  (define (set-node-value! node value) ((node 'set-value!) value))
  (define (add-child! node new-child-tag) ((node 'add-child!) new-child-tag))
  
  (let ((inner-table (make-node '*table*)))
    (define (lookup current-node)
      (lambda (keys)
        (cond ((not current-node) #f)
              ((null? keys) (node-value current-node)) ; The current node is the destination
              (else ((lookup (get-child current-node (car keys))) (cdr keys)))))) ; Recurse, strip off a key and get the child with the head key. Assumes the head key exists.
    (define (insert! current-node)
      (lambda (keys value)
        (if (null? keys) ; No keys?
            (set-node-value! current-node value) ; The current node is the destination; set the value
            (let ((next (get-child current-node (car keys)))) ; See if the next node exists
              (if next
                  ((insert! next) (cdr keys) value) ; Recurse to it
                  (let ((next (add-child! current-node (car keys)))) ; Create the next node
                    ((insert! next) (cdr keys) value)))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup) (lookup inner-table))
            ((eq? m 'insert!) (insert! inner-table))
            ((eq? m 'print) (pretty-print-node inner-table))
            (else (error "Unknown operation -- TABLE" m)))) ; Recurse to it
    dispatch))

(define (get table keys) ((table 'lookup) keys))
(define (put! table keys value) ((table 'insert!) keys value))
(define (print-table table) (table 'print))

(define (pretty-print-node node)
  (define (indent n)
    (if (> n 0)
        (begin
          (display "  ")
          (indent (- n 1)))))

  (define (print-node node depth)
    (indent depth)
    (display (node 'tag))

    (if (node 'value)
        (begin
          (display " = ")
          (display (node 'value)))
        '())

    (newline)

    (for-each
     (lambda (child)
       (print-node child (+ depth 1)))
     (node 'children)))

  (print-node node 0))

(define t (make-table))
(print-table t)

; 1. Empty table: root has no value, any path is missing
(get t '())              ; => #f
(get t '(a))             ; => #f

; 2. Single-level insert and lookup
(put! t '(a) 1 )
(get t '(a))             ; => 1

; 3. Multi-level insert (creates intermediate nodes)
(put! t '(a b c) 42)
(get t '(a b c))         ; => 42
(get t '(a b))           ; => #f   (intermediate node, no value)
(get t '(a))             ; => 1    (unchanged)

; 4. Sibling keys under the same parent
(put! t '(a x) 'ex)
(put! t '(a y) 'why)
(get t '(a x))           ; => ex
(get t '(a y))           ; => why
(get t '(a b c))         ; => 42   (still there)

; 5. Overwrite an existing value
(put! t '(a) 100)
(get t '(a))             ; => 100

; 6. Missing paths
(get t '(z))             ; => #f
(get t '(a b c d))       ; => #f
(get t '(a q))           ; => #f
(get t '(z y))           ; => #f   (z missing, y remaining)
(get t '(z y x))         ; => #f   (several keys remaining after the miss)
(get t '(a q r))         ; => #f   (a exists, q missing, r remaining)
(get t '(a b c d e))     ; => #f   (miss at d, e remaining)
(get t '(a b q c))       ; => #f   (miss after two successful steps)

; 7. Root value via empty key list
(put! t '() 'root)
(get t '())              ; => root

; 8. Separate tables don't share state
(define t2 (make-table))
(put! t2 '(a) 'other)
(get t2 '(a))            ; => other
(get t '(a))             ; => 100

; 9. Mixed key paths in a fresh table
(define t3 (make-table))
(put! t3 '(math +) 43)
(put! t3 '(math -) 45)
(put! t3 '(letters a) 97)
(get t3 '(math +))       ; => 43
(get t3 '(letters a))    ; => 97

; 10. Pretty-printing
(print-table t3)
; Children are consed on the front, so most recent first:
; *table*
;   letters
;     a = 97
;   math
;     - = 45
;     + = 43