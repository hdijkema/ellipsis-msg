#lang info

(define pkg-authors '(hnmdijkema))
(define version "0.1.0")
(define license 'Apache-2.0)
(define collection "ellipsis-msg")
(define pkg-desc "A message% with ellipsis (...) to the left or right")

(define scribblings
  '(
    ("scribblings/ellipsis-msg.scrbl" () (gui) "ellipsis-msg")
    )
  )

(define deps
  '("racket/gui"))

(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"))

