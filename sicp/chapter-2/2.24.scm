(list 1 (list 2 (list 3 4)))

;; Box-and-pointer:
;; l0: (1, *) -> (l1, /)
;; l1: (2, *) -> (l2, /)
;; l2: (3, *) -> (4, /)

;; Tree:
;; Only leaves have values.
;; l0: Root has left child 1 and right l1.
;; l1: Has left child 2 and right l2.
;; l2: Has left child 3 and right 4.