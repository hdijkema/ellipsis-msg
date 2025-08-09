#lang info

(define pkg-authors '(hnmdijkema))
(define version "0.1.3")
(define license 'Apache-2.0)
(define collection "ellipsis-msg")
(define pkg-desc "A message% with ellipsis (...) to the left or right")

(define scribblings
  '(
    ("scribblings/ellipsis-msg.scrbl" () (gui) "ellipsis-msg")
    ("scribblings/example.mp4" () (gui) "example.mp4")
    )
  )

(define deps
  '("racket/gui" "racket/base" "racket"))

(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"))

