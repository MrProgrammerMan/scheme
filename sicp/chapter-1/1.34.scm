(define (f g) (g 2))
(f f)

;;   (f f)
;; = (f 2)
;; = (2 2)
;;   error: 2 is not applicable to arguments given: 2