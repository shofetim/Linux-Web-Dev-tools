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
       (list (tt "It was good advice"))))

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
 (text "It Works" '(bold . modern) 40))

(slide
 #:title "A developer's tools"
 'alts
 (list
  (list
   (hc-append
    (bitmap (build-path "img" "php.jpg"))
    (bitmap (build-path "img" "emacs.png"))
    (bitmap (build-path "img" "git.png"))))
  (list
   (titlet "Or maybe")
   (hc-append
    (bitmap (build-path "img" "racket.png"))
    (bitmap (build-path "img" "emacs.png"))
    (bitmap (build-path "img" "git.png"))))))

(slide
 #:title "But that isn't a full toolbox"
 (bitmap (build-path "img" "toolbox.jpg")))

(slide
 #:title "Tools"
 'alts 
 (list
  (list
   (item "Firebug / Developer Tools")
   (item "HTTPFox")
   (item "Chrome Sniffer")
   (item "Curl")
   (item "Pagespeed / ySlow")
   (item "AB (Apache Benchmark"))
  (list
   (item "htop + nameless python script")
   (item "rxvt-unicode + screen")
   (item "Virtualbox")
   (item "Gimp & Inkscape")
   (item "SLOCC")
   (item "CutyCapt")
   (item "CI Joe"))))

(slide
 #:title "Firebug / Developer Tools"
 )

(start-at-recent-slide)

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
