#lang info

(define pkg-authors '(hnmdijkema))
(define version "0.2.1")
(define license 'Apache-2.0)
(define collection "ellipsis-msg")
(define pkg-desc "A message% with ellipsis (...) to the left or right")

(define scribblings
  '(
    ("scribblings/ellipsis-msg.scrbl" () (gui-library) "ellipsis-msg")
    )
  )

(define deps
  '("racket/gui" "racket/base" "racket"))

(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"
    "scribble/example"
    "scribble/core"
    "scribble/html-properties"
    ))
