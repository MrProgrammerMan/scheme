;; Cons represents a common data structure known as a linked list or singly linked list.
;; It constructs a list such that you end up with a pointer to the head of the list, and can traverse down to further elements as needed.
;; You cannot, however, instantly access element n, which includes the last item of the list.
;; Therefore, cdring down a list(the only real way to process a list) will give you the first item first,
;; and if you build a new list with that item, cons will make it the last item of the new list.
;; The best iterative solution to this problem is likely an extra reverse at the end. This means you can traverse the list (O(n)), reverse it(O(n)) giving a total assymptotic efficiency of O(n).
;; The "naive" attempt of flipping the logic results in a weird sort of nested data structure, which is not a list at all.
;; It will at least not conform to our other interfaces that work with lists.