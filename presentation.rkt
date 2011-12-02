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
 'alts
 (list 
  (list (para "I found a very wide range of stats, alot of them disagree, these"
           "numbers are an educated guess from what I found, and my experience"))
  (list
   (tt "Websites")
   (t "80% + deployed on Linux"))
  (list
   (tt "Languages")
   (para "For many (most?) tools and languages posix is the only first class citizen")
   'next (item "Node.js")
   'next (item "PHP")
   'next (item "etc."))
  (list (tt "What about .NET?")
        'next
        (t "Mono"))
  (list (tt "Other things")
        (item "epoll/kqueue")
        'next
        (item "Support from virtualization providers")
        'next
        (item "Cost")
        'next
        (item "Ease of remote administration")
        'next
        (item "etc."))))

(slide
 #:title "Other *nix systems"
 (tt "I recently looked at alternative *nix systems")
 'next
 (item "Memory footprint")
 'next
 (item "TCP stack")
 'next
 (item "Security")
 'next
 (item "Speed")
 'next
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
   (item "Curl")
   (item "Pagespeed / ySlow")
   (item "htop + nameless python script"))
  (list
   (item "rxvt-unicode + screen")
   (item "Gimp & Inkscape")
   (item "SLOCC")
   (item "CutyCapt")
   (item "CI Joe"))))

;;TODO
(slide
 #:title "Firebug / Developer Tools"
 (t "Demo"))

;;TODO
(slide
 #:title "HTTPFox"
 (tt "A packet sniffer (as a Firefox Extension)")
 (t "Demo"))

(slide
 #:title "Curl"
 (tt "Manipulate HTTP")
 (t "Great for seeing what a site is running...")
 (size-in-pixels (bitmap (build-path "img" "curl.png"))))

;;TODO
(slide
 #:title "Pagespeed / ySlow"
 (tt "Measure why pages are load slowly")
 (t "Demo"))

(slide
 #:title "Memory Usage"
 'alts
 (list
  (list 
   (titlet "Htop")
   (size-in-pixels (bitmap (build-path "img" "htop.png"))))
  (list 
   (titlet "ps_mem.py")
   (size-in-pixels (bitmap (build-path "img" "ps_mem.jpg"))))))

;;TODO
(slide
 #:title "rxvt-unicode & screen"
 (tt "A good / memory lite terminal + screen")
 (size-in-pixels (bitmap (build-path "img" "screen.png"))))

(slide
 #:title "Gimp & Inkscape"
 (item "Gimp works well as a Photoshop replacement")
 (item "Inkscape is a great vector graphics editor")
 (item "Imagemagic is also handy, particularly from the commandline or scripts"))

(slide
 #:title "SLOCC"
 'alts
 (list
  (list
   (tt "Source Lines of Code Count")
   (item (colorize (t "http://www.dwheeler.com/sloccount/") "green"))
   (item "Knows most common languages")
   (item "You should know how big your own codebase is...")
   (item "Great for getting the feel for a new codebase")
   (item "Helpful in picking which app to use for your CMS etc"))
  (list
   (tt "CakePHP")
   (size-in-pixels (bitmap (build-path "img" "slocc.png"))))))

(slide
 #:title "CutyCapt"
 (t "Scriptable, full page, website screen capture tool")
 (t "PNG or PDF output...")
 (colorize (t "http://cutycapt.sourceforge.net/") "green"))

(slide
 #:title "CI Joe or Git Hook"
 'alts
 (list
  (list (colorize (t "https://github.com/defunkt/cijoe") "green")
        (bitmap (build-path "img" "ci-joe.png")))
  (list
   (t "or a simple githook")
   (vl-append
    (tt "#!/bin/sh")
    (tt "cd ..")
    (tt "env -i git reset --hard")))))

(slide
 (tt "End"))