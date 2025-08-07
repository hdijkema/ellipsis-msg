#lang scribble/manual

@(require
   scribble/example
   (for-label racket/gui
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

}

