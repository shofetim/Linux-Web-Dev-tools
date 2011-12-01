#lang slideshow
(require slideshow
         racket/draw)

;; A pict to use behind the main content
(define fade-bg
  (let ([w (+ (* 2 margin) client-w)]
        [h (+ (* 2 margin) client-h)]
        [trans (make-object brush% "white" 'transparent)]
        [inside (make-object brush% "white" 'solid)])
    (inset (dc (lambda (dc x y)
                 (let ([b (send dc get-brush)]
                       [p (send dc get-pen)]
                       [draw-one
                        (lambda (i)
                          (send dc draw-rectangle
                                (+ x i) (+ y i)
                                (- w (* 2 i)) (- h (* 2 i))))])
                   (send dc set-brush trans)
                   (color-series 
                    dc margin 1
                    (make-object color% "black")
                    (make-object color% "white")
                    draw-one
                    #t #t)
                   (send dc set-brush inside)
                   (draw-one margin)
                   (send dc set-pen p)
                   (send dc set-brush b)))
               w h 0 0)
           (- margin))))

;; Setup
(current-slide-assembler
  (lambda (s v-sep p)
    (lt-superimpose fade-bg 
         (apply vc-append v-sep
                (if s
                    (list (evenize-width (if (pict? s) s (titlet s))) p)
                    (list p))))))


;; Slides
(slide
 (titlet "Linux Web Dev")
 (blank)
 (size-in-pixels
  (bitmap (build-path "img" "linux.png")))
 (blank)
 (colorize (it "Jordan Schatz") "blue")
 (text "jordan@noionlabs.com" '(bold . modern) 25)
 (para #:align 'center
       "Download the presentation, code etc at:"
       "github.com/shofetim/Linux-Web-Dev-tools"))

(slide
 #:title "Why I develop on Linux"
 (colorize (tt "\"If you want to learn to program, learn linux\"") "blue"))

(slide
 #:title "Do other people develop on linux?"
 'next (item "Websites deployed on linux")
 'next (item "languages/tools treat posix as the only first class citizen")
 'next (subitem "epoll/kqueue")
 'next (subitem "node.js")
 'next (item ".NET")
 'next (item "Remote administration / control")
 'next (item "Support from virtualization providers")
 'next (item "Universities that require unix knowledge")
)