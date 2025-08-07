#lang racket

(require racket/gui)
(require (prefix-in str: srfi/13))

(provide ellipsis-msg%)

(define ellipsis-msg%
    (class message%
      (super-new)

      (init-field [font normal-control-font] [ellipsis 'right])

      (define my_label "")
      (define ellipsis_label "")

      (define/private (ellipsize w l)
        (let ((ext (call-with-values (lambda () (get-window-text-extent l font))
                                          (lambda (w h) w))))
          ;(printf "label: ~a, max-w: ~a, w: ~a\n" l w ext)
          (if (or (< w 10) (<= ext w))
              l
              (let* ((factor (/ w ext))
                     (strl   (string-length l))
                     (n-strl (round (* strl factor)))
                     (drop   (- strl n-strl)))
                (if (eq? ellipsis 'right)
                    (let ((nl (str:string-drop l drop)))
                      (printf "new-try ~a\n" nl)
                      (ellipsize w (str:string-drop l drop)))
                    (let ((nl (str:string-drop-right l drop)))
                      (printf "new-try ~a\n" nl)
                      (ellipsize w (str:string-drop-right l drop))))))))
      
      (define/override (set-label l . resize)
        (let ((rsz #f))
          (unless (null? resize)
            (set! rsz (car resize)))
          (if (eq? rsz #t)
            (super set-label l)
            (let* ((width (send this get-width))
                   (ext (call-with-values (lambda () (get-window-text-extent l font))
                                          (lambda (w h) w)))
                   )
              (set! my_label l)
              ;(printf "Ellipsis = ~a\n" ellipsis)
              (set! ellipsis_label
                    (if (< ext width)
                        l
                        (ellipsize width (string-append
                                            (if (eq? ellipsis 'left) "..." "")
                                            l
                                            (if (eq? ellipsis 'right) "..." "")))))
              ;(printf "Setting label to ~a\n" ellipsis_label)
              (super set-label ellipsis_label)))))
      
      (define/override (get-label)
        my_label)
      ))

;(define win (new frame% [label "Hi there!"]))
;(define hp1 (new horizontal-pane% [parent win]))
;(define btn1 (new button% [label "Longer 1"] [parent hp1] [callback (lambda (b e) (send lbl1 set-label "This is a very long text, yes a longer text than we initial put"))]))
;(define lbl1 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp1] [ellipsis 'right]))
;(define hp2 (new horizontal-pane% [parent win]))
;(define btn2 (new button% [label "Longer 2"] [parent hp2] [callback (lambda (b e) (send lbl2 set-label "This is a very long second text, yes a longer text than we initial put"))]))
;(define lbl2 (new ellipsis-msg% [label "This is an ellipsis label"] [parent hp2] [ellipsis 'left]))
;(send win show #t)
