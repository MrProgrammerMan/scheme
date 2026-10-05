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


;;; ------------------------------------------------------------
;;; Tests
;;; ------------------------------------------------------------
;;; Each section builds its own fresh table, so sections are
;;; independent. Failures print FAIL with expected/actual; passes
;;; are silent except for the final tally.
 
(define tests-run 0)
(define tests-failed 0)
 
(define (check description expected actual)
  (set! tests-run (+ tests-run 1))
  (if (not (equal? expected actual))
      (begin
        (set! tests-failed (+ tests-failed 1))
        (display "FAIL: ") (display description)
        (display " | expected ") (display expected)
        (display ", got ") (display actual)
        (newline))))
 
;; Empty table
(let ((t (make-table)))
  (check "empty table, root"       #f (get t '()))
  (check "empty table, any path"   #f (get t '(a))))
 
;; Single-level insert, then overwrite
(let ((t (make-table)))
  (put! t '(a) 1)
  (check "single-level insert"     1   (get t '(a)))
  (put! t '(a) 100)
  (check "overwrite"               100 (get t '(a))))
 
;; Multi-level insert creates valueless intermediate nodes
(let ((t (make-table)))
  (put! t '(a) 1)
  (put! t '(a b c) 42)
  (check "deep insert"             42  (get t '(a b c)))
  (check "intermediate has no value" #f (get t '(a b)))
  (check "existing value untouched"  1  (get t '(a))))
 
;; Siblings under the same parent don't interfere
(let ((t (make-table)))
  (put! t '(a b c) 42)
  (put! t '(a x) 'ex)
  (put! t '(a y) 'why)
  (check "sibling x"               'ex  (get t '(a x)))
  (check "sibling y"               'why (get t '(a y)))
  (check "earlier branch intact"   42   (get t '(a b c))))
 
;; Missing paths return #f, wherever the miss happens
(let ((t (make-table)))
  (put! t '(a b c) 42)
  (check "miss at first key"       #f (get t '(z)))
  (check "miss with keys left"     #f (get t '(z y x)))
  (check "miss at second key"      #f (get t '(a q)))
  (check "miss mid-path"           #f (get t '(a q r)))
  (check "miss after two hits"     #f (get t '(a b q c)))
  (check "path longer than table"  #f (get t '(a b c d e))))
 
;; Root value via the empty key list
(let ((t (make-table)))
  (put! t '() 'root)
  (check "root value"              'root (get t '())))
 
;; Separate tables don't share state
(let ((t1 (make-table))
      (t2 (make-table)))
  (put! t1 '(a) 'one)
  (put! t2 '(a) 'two)
  (check "table 1 isolated"        'one (get t1 '(a)))
  (check "table 2 isolated"        'two (get t2 '(a))))
 
;; Keys can be any symbols, including operators
(let ((t (make-table)))
  (put! t '(math +) 43)
  (put! t '(math -) 45)
  (put! t '(letters a) 97)
  (check "operator key +"          43 (get t '(math +)))
  (check "operator key -"          45 (get t '(math -)))
  (check "letters a"               97 (get t '(letters a))))
 
;; Summary
(display tests-run) (display " checks, ")
(display tests-failed) (display " failed")
(newline)
 
;; Pretty-printing (visual check; children are consed on the front,
;; so the most recently added appear first). Expected output:
;;
;; *table*
;;   letters
;;     a = 97
;;   math
;;     - = 45
;;     + = 43
(let ((t (make-table)))
  (put! t '(math +) 43)
  (put! t '(math -) 45)
  (put! t '(letters a) 97)
  (print-table t))