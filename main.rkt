#lang racket

(require racket/gui)

(provide ellipsis-msg%)

(define (string-drop s n)
  (let ((l (string-length s)))
    (if (>= n l)
        ""
        (substring s n))))

(define (string-drop-right s n)
  (let ((l (string-length s)))
    (if (>= n l)
        ""
        (substring s 0 (- l n))
        )))

(define ellipsis-msg%
    (class message%

      (init-field [ellipsis 'right]
                  [font normal-control-font])
      (super-new [font font])

      (define my_label "")
      (define ellipsis_label "")

      (define/private (ellipsize-middle w l r)
        (let* ((str (string-append l "..." r))
               (ext (call-with-values
                    (lambda () (get-window-text-extent str font))
                    (lambda (w h) w))))
          (if (or (< w 10) (<= ext w) (string=? l "") (string=? r ""))
              (string-append l "..." r)
              (let* ((factor (/ w ext))
                     (strl (+ (string-length l) (string-length r)))
                     (n-strl (round (* strl factor)))
                     (drop  (- strl n-strl))
                     (drop-l (inexact->exact (round (/ drop 2.0))))
                     (drop-r (- drop drop-l)))
                (ellipsize-middle w
                                 (string-drop-right l drop-l)
                                 (string-drop r drop-r))))))

      (define/private (ellipsize w l)
        (let* ((ext (call-with-values
                     (lambda () (get-window-text-extent l font))
                     (lambda (w h) w))))
          (if (or (< w 10) (<= ext w) (string=? l ""))
              (if (eq? ellipsis 'right)
                  (string-append (string-drop-right l 3) "...")
                  (string-append "..." (string-drop l 3)))
              (let* ((factor (/ w ext))
                     (strl   (string-length l))
                     (n-strl (round (* strl factor)))
                     (drop   (- strl n-strl)))
                (when (= drop 0) (set! drop 1))
                (if (eq? ellipsis 'left)
                    (let ((nl (string-drop l drop)))
                      (ellipsize w (string-drop l drop)))
                    (let ((nl (string-drop-right l drop)))
                      (ellipsize w (string-drop-right l drop))))
                ))))
      
      (define/override (set-label l . resize)
        (let ((rsz #f))
          (unless (null? resize)
            (set! rsz (car resize)))
          (if (eq? rsz #t)
            (super set-label l)
            (let* ((width (send this get-width))
                   (ext (call-with-values
                         (lambda () (get-window-text-extent l font))
                         (lambda (w h) w)))
                   )
              (set! my_label l)
              (set! ellipsis_label
                    (if (< ext width)
                        l
                        (if (eq? ellipsis 'middle)
                            (let ((middle (inexact->exact
                                           (round
                                            (/ (string-length l) 2.0)))))
                              (ellipsize-middle width
                                                (substring l 0 middle)
                                                (substring l middle)))
                            (ellipsize
                             width
                             (string-append
                              (if (eq? ellipsis 'left) "..." "")
                              l
                              (if (eq? ellipsis 'right) "..." ""))))))
              (super set-label ellipsis_label)))))
      
      (define/override (get-label)
        my_label)
      ))



;(require racket/gui)
;(require ellipsis-msg)
;(define win (new frame% [label "Hi there!"] [width 300]))
;
;(define hp1 (new horizontal-pane% [parent win]))
;(define btn1 (new button% [label "Longer 1"] [parent hp1]
;                  [callback
;                   (lambda (b e)
;                     (send lbl1 set-label
;                           "This is a very long text, yes a longer text than we initial put"))]
;                  ))
;(define lbl1 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp1]
;                  [ellipsis 'right] [auto-resize #t] [stretchable-width #t]))
;
;(define hp2 (new horizontal-pane% [parent win]))
;(define btn2 (new button% [label "Longer 2"] [parent hp2]
;                  [callback
;                   (lambda (b e)
;                     (send lbl2 set-label
;                           "This is a very long second text, yes a longer text than we initial put"))]
;                  ))
;(define lbl2 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp2]
;                  [ellipsis 'left] [auto-resize #t] [stretchable-width #t]))
;
;
;(define hp3 (new horizontal-pane% [parent win]))
;(define btn3 (new button% [label "Longer 3"] [parent hp3]
;                  [callback
;                   (lambda (b e)
;                     (send lbl3 set-label
;                           "This is a third very long text, yes much longer than the initial text"))]
;                  ))
;(define lbl3 (new ellipsis-msg% [label "This is label 3"] [parent hp3]
;                  [ellipsis 'middle] [auto-resize #t] [stretchable-width #t]
;                  [font (make-object font% 12 'default)]
;                  ))
;
;(define hp4 (new horizontal-pane% [parent win]))
;(define lbl4 (new message% [label "This is label 4"] [parent hp4]
;                  [auto-resize #t] [stretchable-width #t]
;                  [font (make-object font% 12 'default)]
;                  ))
;
;(send win show #t)
