#lang racket

(require racket/gui)

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
          (if (< ext w)
              l
              (let* ((factor (/ w ext))
                     (strl   (string-length l))
                     (n-strl (round (* strl factor)))
                     (drop   (- strl n-strl)))
                (if (eq? ellipsis 'right)
                    (ellipsize w (str:string-drop l drop))
                    (ellipsize w (str:string-drop-right l drop)))))))
      
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
              (set! ellipsis_label
                    (if (< ext width)
                        l
                        (ellipsize width (string-append
                                            (if (eq? ellipsis 'left) "..." "")
                                            l
                                            (if (eq? ellipsis 'right) "..." "")))))
              (super set-label ellipsis_label)))))
      
      (define/override (get-label)
        my_label)
      ))