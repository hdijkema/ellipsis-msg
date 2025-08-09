#lang scribble/manual

@(require
   scribble/example
   (for-label ;racket
              ;racket/base
              ;racket/string
              racket/gui
              ;racket/file
              )
  @(for-label ellipsis-msg))

@title[#:tag "ellipsis-msg"]{A message% with ellipsis (...) to the left or right}

@author[@author+email["Hans Dijkema" "hans@dijkewijk.nl"]]

@defmodule[ellipsis-msg]
This module provides a new class @racket[ellipsis-msg%] that will cut the label of with ellipsis (...) when it is too long
for the current width. The @racket[ellipsis] parameter tells where to put the ellipsis. 

@defclass[ellipsis-msg% message% ()]{

An ellipis-msg will cut the label with ellipsis (...) if there's not enough room to hold it.
See also @racket[message%].

@defconstructor[([label (or/c label-string? (is-a?/c bitmap%)
                              (or/c 'app 'caution 'stop))]
                 [parent (or/c (is-a?/c frame%) (is-a?/c dialog%)
                               (is-a?/c panel%) (is-a?/c pane%))]
                 [ellipsis symbol? 'right]
                 [style (listof (or/c 'deleted)) null]
                 [font (is-a?/c font%) normal-control-font]
                 [color (or/c #f string? (is-a?/c color%)) #f]
                 [enabled any/c #t]
                 [vert-margin spacing-integer? 2]
                 [horiz-margin spacing-integer? 2]
                 [min-width (or/c dimension-integer? #f) #f]
                 [min-height (or/c dimension-integer? #f) #f]
                 [stretchable-width any/c #f]
                 [stretchable-height any/c #f]
                 [auto-resize any/c #f])]{
  Creates the ellipsis-msg% with the given ellipsis parameter.
}

@defmethod*[#:mode override ([(set-label (label string?) [resize boolean? #f]) void?])]{
 Sets the message label. If resize = #t, the label will be resized (if auto-resize = #t)
}

@section{Example code}

@#reader scribble/comment-reader 
[racketblock
  (require racket/gui)
  (require ellipsis-msg)
  (define win (new frame% [label "Hi there!"]))
  (define hp1 (new horizontal-pane% [parent win]))
  (define btn1 (new button% [label "Longer 1"] [parent hp1] [callback (lambda (b e) (send lbl1 set-label "This is a very long text, yes a longer text than we initial put"))]))
  (define lbl1 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp1] [ellipsis 'right] [auto-resize #t] [stretchable-width #t]))
  (define hp2 (new horizontal-pane% [parent win]))
  (define btn2 (new button% [label "Longer 2"] [parent hp2] [callback (lambda (b e) (send lbl2 set-label "This is a very long second text, yes a longer text than we initial put"))]))
  (define lbl2 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp2] [ellipsis 'left] [auto-resize #t]  [stretchable-width #t]))
  (send win show #t)
]


}

