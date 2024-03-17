:
#lang sicp

; Exercise 1.3
; Define a procedure that takes three numbers as arguments and returns the sum
; of the squares  of the two larger numbers

(define (best-of-three x y z)
  (cond ((and (> x y) (> x z)) x)
       ((and (> y x) (> y z)) y)
       (else z)))

(best-of-three 5 6 2)
; Exercise 1.11
