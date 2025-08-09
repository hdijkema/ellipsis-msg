#lang scribble/manual

@(require
   scribble/example
   scribble/core
   scribble/html-properties
   (for-label ;racket
              ;racket/base
              ;racket/string
              racket/gui
              ;racket/file
              )
   ;scribble/html/html
   ;scribble/html/extra
  @(for-label ellipsis-msg))


@(define(add-video video)
   (make-element
    (make-style #f
                (list
                 (make-alt-tag "video")
                 (make-attributes (list (cons 'controls "")
                                        (cons 'width "400")
                                        (cons 'src video)))
                 )
                )
    null))

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
                 [ellipsis (or/c '(left middle right)) 'right]
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

}

@section{Example code}

The code underneath produces the following output:

@add-video{../../resources/example.mp4}

@#reader scribble/comment-reader 
[racketblock
  (require racket/gui)
  (require ellipsis-msg)
  (define win (new frame% [label "Hi there!"] [width 300]))

  (define hp1 (new horizontal-pane% [parent win]))
  (define btn1 (new button% [label "Longer 1"] [parent hp1]
                    [callback
                     (lambda (b e)
                       (send lbl1 set-label
                             "This is a very long text, yes a longer text than we initial put"))]
                    ))
  (define lbl1 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp1]
                    [ellipsis 'right] [auto-resize #t] [stretchable-width #t]))

  (define hp2 (new horizontal-pane% [parent win]))
  (define btn2 (new button% [label "Longer 2"] [parent hp2]
                    [callback
                     (lambda (b e)
                       (send lbl2 set-label
                             "This is a very long second text, yes a longer text than we initial put"))]
                    ))
  (define lbl2 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp2]
                    [ellipsis 'left] [auto-resize #t] [stretchable-width #t]))


  (define hp3 (new horizontal-pane% [parent win]))
  (define btn3 (new button% [label "Longer 3"] [parent hp3]
                    [callback
                     (lambda (b e)
                       (send lbl3 set-label
                             "This is a third very long text, yes much longer than the initial text"))]
                    ))
  (define lbl3 (new ellipsis-msg% [label "This is label 3"] [parent hp3]
                    [ellipsis 'middle] [auto-resize #t] [stretchable-width #t]
                    [font (make-object font% 12 'default)]
                    ))

  (define hp4 (new horizontal-pane% [parent win]))
  (define lbl4 (new message% [label "This is label 4"] [parent hp4]
                    [auto-resize #t] [stretchable-width #t]
                    [font (make-object font% 12 'default)]
                    ))

  (send win show #t)
]

