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

@defclass[columns-pane% vertical-pane% ()]{

A columns pane arranges its subwindows in columns. The number of columns must be given in advance and initializes to 1.
See also @racket[pane%].

@defconstructor[([label (or/c label-string?)]
                 [parent (or/c (is-a?/c frame%) (is-a?/c dialog%) 
                               (is-a?/c panel%) (is-a?/c pane%))]
                 [[ellipsis symbol? 'right]
                  [font (is-a/c font%) normal-control-font]
                  [auto-resize boolean? #f]
                  [color (or/c #f string? (is-a?/c color%)) #f]
                  [enabled any/c #t]
                  [vert-margin spacing-integer? 0]
                  [horiz-margin spacing-integer? 0]
                  [min-width (or/c dimension-integer? #f) #f]
                  [min-height (or/c dimension-integer? #f) #f]
                  [stretchable-width any/c #t]
                  [stretchable-height any/c #t]]
                  )]{
}

@defmethod*[([(set-label (label string?) [resize or/c boolean? default #f])])]{
 Sets the message label. If resize = #t, the label will be resized (if auto-resize = #t)
}

}

