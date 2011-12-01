#lang slideshow
(require racket/draw)

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

(define (evenize-width p)
  (let ([w (pict-width p)])
    (inset p 0 0 (+ (- (ceiling w) w)
                    (modulo (ceiling w) 2)) 0)))

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
       "Download the presentation and files at:"
       "github.com/shofetim/Linux-Web-Dev-tools"))

(slide
 #:title "Why I develop on Linux"
 'alts 
 (list (list (colorize (tt "\"If you want to learn to program, learn linux\"") "blue"))
       (list (t "It was good advice"))))

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

(slide
 #:title "Other 'nix systems"
 (item "Memory utilization")
 (item "TCP stack")
 (item "Security")
 (item "Speed")
 (colorize (t "Stayed with linux") "blue"))

(slide
 #:title "Alot of people use Mac"
 (size-in-pixels
  (bitmap (build-path "img" "mac.png")))
 'next
 (t "Its pretty")
 'next
 (t "it \"Just Works\"")
 'next
 (t "(maybe)"))

(slide
 (titlet "I use: ")
 'next
 (para #:align 'left "+ Mutter")
 'next
 (para #:align 'left "+ AWN")
 'next
 (para #:align 'left "+ Gnome Do"))

(slide 
 #:title "Pretty Enough"
 (cc-superimpose (bitmap (build-path "img" "desktop.png"))))

(slide
 #:title "Intro"
 (para
  "Mostly if you are writing code everyday you just get good at your language,"
   "platform/framework, editor, revision control system, and maybe a good"
   "statistical analysis tool / linter. But going over those would just be"
   "interesting to someone who is also a pro dev...")
 (para "But to handle everything that comes up one needs a full toolbox of tools,"
        "and most of them are great for casual use to."))
(start-at-recent-slide)

(slide
 #:title "Firebug / Developer Tools")

(slide
 #:title "HTTPFox (or Wireshark)")

(slide
 #:title "Chrome Sniffer")

(slide
 #:title "Curl")

(slide
 #:title "Pagespeed / ySlow")

(slide
 #:title "AB (apache benchmark")

(slide
 #:title "Memory Usage")

(slide
 #:title "rxvt-unicode & screen")

(slide
 #:title "Virtualbox")

(slide
 #:title "Gimp & Inkscape")

(slide
 #:title "SLOCC")

(slide
 #:title "CutyCapt")

(slide
 #:title "CI Joe")
