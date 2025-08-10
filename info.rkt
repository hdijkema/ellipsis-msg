#lang info

(define pkg-authors '(hnmdijkema))
(define version "0.2.4")
(define license 'Apache-2.0)
(define collection "ellipsis-msg")
(define pkg-desc "ellipsis-msg% - A message% with ellipsis (...) to the left, right or in the middle")

(define scribblings
  '(
    ("scribblings/ellipsis-msg.scrbl" () (gui-library) "ellipsis-msg")
    )
  )

(define deps
  '("racket/gui" "racket/base" "racket"))

(define build-deps
  '("racket-doc"
    "draw-doc"
    "rackunit-lib"
    "scribble-lib"
    ))
