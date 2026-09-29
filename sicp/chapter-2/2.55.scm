(car ''a)
;; ' is syntactic sugar for (quote <SOMETHING>).
;; This is a list where the first item is the procedure quote.
;; Usually, this evaluates to "exactly and concretely the symbol a".
;; However, this is exactly what happens to the expression itself when an extra quote is added.
(car ''a)
(car (quote (quote a)))
(car '(quote a)) ;; EXACTLY a list of the symbols quote and a