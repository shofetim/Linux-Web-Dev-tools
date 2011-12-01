#lang slideshow
(require slideshow)

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
 #:title "More Paragraph Alignment"
 (frame
  (para #:align 'center
        "The" (tt "#:align 'center") "option for" (tt "para") "generates"
        "a paragraph with centered lines of text"))
 (frame
  (para "This line uses the" (tt "#:fill? #f") "option"))
 (para "The" (tt "#:fill? #f") "option creates a paragraph"
            "that is wrapped to fit the slide, but it allows"
            "the resulting pict to be more narrow than the slide"))
