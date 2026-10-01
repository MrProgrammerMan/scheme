#lang sicp

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin
      (set! balance (+ balance amount))
      balance))
  (define (dispatch op)
    (cond ((eq? op 'deposit) deposit)
          ((eq? op 'withdraw) withdraw)
          (else (error "Unsupported operation" op))))
  (let ((failed-tries 0))
    (lambda (password-in arg)
      (if (eq? password password-in)
          (begin
            (set! failed-tries 0)
            (dispatch arg)) ;; Will result in a procedure
          (begin
            (set! failed-tries (+ 1 failed-tries))
            (lambda (amount)
              (if (>= failed-tries 7)
                  call-the-cops
                  "Incorrect password"))))))) ;; Compatible return type

(define call-the-cops "SIRENS!!!")

(define a (make-account 100 '1234))
((a '1234 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a '1234 'withdraw) 40)
((a 'wrong-password 'withdraw) 40)
((a '1234 'withdraw) 40)